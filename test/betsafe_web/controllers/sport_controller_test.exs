defmodule BetsafeWeb.SportControllerTest do
  use BetsafeWeb.ConnCase

  import Betsafe.SportsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all sports", %{conn: conn} do
      conn = get(conn, ~p"/sports")
      assert html_response(conn, 200) =~ "Listing Sports"
    end
  end

  describe "new sport" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/sports/new")
      assert html_response(conn, 200) =~ "New Sport"
    end
  end

  describe "create sport" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/sports", sport: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/sports/#{id}"

      conn = get(conn, ~p"/sports/#{id}")
      assert html_response(conn, 200) =~ "Sport #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/sports", sport: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Sport"
    end
  end

  describe "edit sport" do
    setup [:create_sport]

    test "renders form for editing chosen sport", %{conn: conn, sport: sport} do
      conn = get(conn, ~p"/sports/#{sport}/edit")
      assert html_response(conn, 200) =~ "Edit Sport"
    end
  end

  describe "update sport" do
    setup [:create_sport]

    test "redirects when data is valid", %{conn: conn, sport: sport} do
      conn = put(conn, ~p"/sports/#{sport}", sport: @update_attrs)
      assert redirected_to(conn) == ~p"/sports/#{sport}"

      conn = get(conn, ~p"/sports/#{sport}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, sport: sport} do
      conn = put(conn, ~p"/sports/#{sport}", sport: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Sport"
    end
  end

  describe "delete sport" do
    setup [:create_sport]

    test "deletes chosen sport", %{conn: conn, sport: sport} do
      conn = delete(conn, ~p"/sports/#{sport}")
      assert redirected_to(conn) == ~p"/sports"

      assert_error_sent 404, fn ->
        get(conn, ~p"/sports/#{sport}")
      end
    end
  end

  defp create_sport(_) do
    sport = sport_fixture()
    %{sport: sport}
  end
end
