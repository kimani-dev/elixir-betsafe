defmodule BetsafeWeb.GameControllerTest do
  use BetsafeWeb.ConnCase

  import Betsafe.SportsFixtures

  @create_attrs %{odds_team_a: 120.5, odds_team_b: 120.5, odds_draw: 120.5, outcome: "some outcome"}
  @update_attrs %{odds_team_a: 456.7, odds_team_b: 456.7, odds_draw: 456.7, outcome: "some updated outcome"}
  @invalid_attrs %{odds_team_a: nil, odds_team_b: nil, odds_draw: nil, outcome: nil}

  describe "index" do
    test "lists all games", %{conn: conn} do
      conn = get(conn, ~p"/games")
      assert html_response(conn, 200) =~ "Listing Games"
    end
  end

  describe "new game" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/games/new")
      assert html_response(conn, 200) =~ "New Game"
    end
  end

  describe "create game" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/games", game: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/games/#{id}"

      conn = get(conn, ~p"/games/#{id}")
      assert html_response(conn, 200) =~ "Game #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/games", game: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Game"
    end
  end

  describe "edit game" do
    setup [:create_game]

    test "renders form for editing chosen game", %{conn: conn, game: game} do
      conn = get(conn, ~p"/games/#{game}/edit")
      assert html_response(conn, 200) =~ "Edit Game"
    end
  end

  describe "update game" do
    setup [:create_game]

    test "redirects when data is valid", %{conn: conn, game: game} do
      conn = put(conn, ~p"/games/#{game}", game: @update_attrs)
      assert redirected_to(conn) == ~p"/games/#{game}"

      conn = get(conn, ~p"/games/#{game}")
      assert html_response(conn, 200) =~ "some updated outcome"
    end

    test "renders errors when data is invalid", %{conn: conn, game: game} do
      conn = put(conn, ~p"/games/#{game}", game: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Game"
    end
  end

  describe "delete game" do
    setup [:create_game]

    test "deletes chosen game", %{conn: conn, game: game} do
      conn = delete(conn, ~p"/games/#{game}")
      assert redirected_to(conn) == ~p"/games"

      assert_error_sent 404, fn ->
        get(conn, ~p"/games/#{game}")
      end
    end
  end

  defp create_game(_) do
    game = game_fixture()
    %{game: game}
  end
end
