defmodule BetsafeWeb.SportController do
  use BetsafeWeb, :controller

  alias Betsafe.Sports
  alias Betsafe.Sports.Sport

  def index(conn, _params) do
    sports = Sports.list_sports()
    render(conn, :index, sports: sports)
  end

  def new(conn, _params) do
    changeset = Sports.change_sport(%Sport{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"sport" => sport_params}) do
    case Sports.create_sport(sport_params) do
      {:ok, sport} ->
        conn
        |> put_flash(:info, "Sport created successfully.")
        |> redirect(to: ~p"/sports/#{sport}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sport = Sports.get_sport!(id)
    render(conn, :show, sport: sport)
  end

  def edit(conn, %{"id" => id}) do
    sport = Sports.get_sport!(id)
    changeset = Sports.change_sport(sport)
    render(conn, :edit, sport: sport, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sport" => sport_params}) do
    sport = Sports.get_sport!(id)

    case Sports.update_sport(sport, sport_params) do
      {:ok, sport} ->
        conn
        |> put_flash(:info, "Sport updated successfully.")
        |> redirect(to: ~p"/sports/#{sport}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, sport: sport, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sport = Sports.get_sport!(id)
    {:ok, _sport} = Sports.delete_sport(sport)

    conn
    |> put_flash(:info, "Sport deleted successfully.")
    |> redirect(to: ~p"/sports")
  end
end
