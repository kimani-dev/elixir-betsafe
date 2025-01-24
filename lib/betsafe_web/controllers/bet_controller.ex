defmodule BetsafeWeb.BetController do
  use BetsafeWeb, :controller

  alias Betsafe.Repo
  alias Betsafe.Bets
  alias Betsafe.Bets.Bet

  def index(conn, _params) do
    bets = Bets.list_bets() |> Repo.preload([:user, game: [:team_a, :team_b]])
    render(conn, :index, bets: bets)
  end

  def new(conn, _params) do
    changeset = Bets.change_bet(%Bet{})
    games = Betsafe.Sports.list_games() |> Repo.preload([:team_a, :team_b]) |>
    Enum.map(fn game -> {game.team_a.name <> " vs " <> game.team_b.name, game.id} end)
    users = Betsafe.Account.list_users() |> Enum.map(&{&1.first_name <> " " <> &1.last_name, &1.id})
    predictions = ["Team A", "Team B", "Draw"]
    render(conn, :new, changeset: changeset, games: games, users: users, predictions: predictions)
  end

  def create(conn, %{"bet" => bet_params}) do
    case Bets.create_bet(bet_params) do
      {:ok, bet} ->
        conn
        |> put_flash(:info, "Bet created successfully.")
        |> redirect(to: ~p"/bets/#{bet}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bet = Bets.get_bet!(id)
    render(conn, :show, bet: bet)
  end

  def edit(conn, %{"id" => id}) do
    bet = Bets.get_bet!(id)
    changeset = Bets.change_bet(bet)
    render(conn, :edit, bet: bet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bet" => bet_params}) do
    bet = Bets.get_bet!(id)

    case Bets.update_bet(bet, bet_params) do
      {:ok, bet} ->
        conn
        |> put_flash(:info, "Bet updated successfully.")
        |> redirect(to: ~p"/bets/#{bet}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, bet: bet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bet = Bets.get_bet!(id)
    {:ok, _bet} = Bets.delete_bet(bet)

    conn
    |> put_flash(:info, "Bet deleted successfully.")
    |> redirect(to: ~p"/bets")
  end
end
