defmodule BetsafeWeb.PageController do
  alias Betsafe.Sports
  use BetsafeWeb, :controller

  def home(conn, _params) do
      render(conn, :home, layout: false)
  end

  def dashboard(conn, _params) do
    games = Sports.list_games()
    render(conn, :dashboard, games: games)
  end
end
