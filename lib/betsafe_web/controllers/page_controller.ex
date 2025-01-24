defmodule BetsafeWeb.PageController do
  use BetsafeWeb, :controller

  def home(conn, _params) do
      render(conn, :home, layout: false)
  end

  def dashboard(conn, _params) do
    render(conn, :dashboard)
  end
end
