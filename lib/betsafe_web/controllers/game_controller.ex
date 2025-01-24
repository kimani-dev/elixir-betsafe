defmodule BetsafeWeb.GameController do
  use BetsafeWeb, :controller

  alias Betsafe.Repo
  alias Betsafe.Teams
  alias Betsafe.Sports
  alias Betsafe.Sports.Game

  def index(conn, _params) do
    games =
      Sports.list_games()
      |> Repo.preload([:team_a, :team_b, :sport])

    render(conn, :index, games: games)
  end

  def new(conn, _params) do
    changeset = Sports.change_game(%Game{})
    teams = Teams.list_teams() |> Enum.map(&{&1.name, &1.id})
    sports = Sports.list_sports() |> Enum.map(&{&1.name, &1.id})
    render(conn, :new, changeset: changeset, teams: teams, sports: sports)
  end

  def create(conn, %{"game" => game_params}) do
    case Sports.create_game(game_params) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: ~p"/games/#{game}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Sports.get_game!(id)
    render(conn, :show, game: game)
  end

  def edit(conn, %{"id" => id}) do
    game = Sports.get_game!(id)

    teams = Teams.list_teams() |> Enum.map(&{&1.name, &1.id})
    sports = Sports.list_sports() |> Enum.map(&{&1.name, &1.id})
    changeset = Sports.change_game(game)
    render(conn, :edit, game: game, changeset: changeset, teams: teams, sports: sports)
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = Sports.get_game!(id)

    case Sports.update_game(game, game_params) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game updated successfully.")
        |> redirect(to: ~p"/games/#{game}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, game: game, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = Sports.get_game!(id)
    {:ok, _game} = Sports.delete_game(game)

    conn
    |> put_flash(:info, "Game deleted successfully.")
    |> redirect(to: ~p"/games")
  end
end
