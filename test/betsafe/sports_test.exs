defmodule Betsafe.SportsTest do
  use Betsafe.DataCase

  alias Betsafe.Sports

  describe "sports" do
    alias Betsafe.Sports.Sport

    import Betsafe.SportsFixtures

    @invalid_attrs %{name: nil}

    test "list_sports/0 returns all sports" do
      sport = sport_fixture()
      assert Sports.list_sports() == [sport]
    end

    test "get_sport!/1 returns the sport with given id" do
      sport = sport_fixture()
      assert Sports.get_sport!(sport.id) == sport
    end

    test "create_sport/1 with valid data creates a sport" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Sport{} = sport} = Sports.create_sport(valid_attrs)
      assert sport.name == "some name"
    end

    test "create_sport/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sports.create_sport(@invalid_attrs)
    end

    test "update_sport/2 with valid data updates the sport" do
      sport = sport_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Sport{} = sport} = Sports.update_sport(sport, update_attrs)
      assert sport.name == "some updated name"
    end

    test "update_sport/2 with invalid data returns error changeset" do
      sport = sport_fixture()
      assert {:error, %Ecto.Changeset{}} = Sports.update_sport(sport, @invalid_attrs)
      assert sport == Sports.get_sport!(sport.id)
    end

    test "delete_sport/1 deletes the sport" do
      sport = sport_fixture()
      assert {:ok, %Sport{}} = Sports.delete_sport(sport)
      assert_raise Ecto.NoResultsError, fn -> Sports.get_sport!(sport.id) end
    end

    test "change_sport/1 returns a sport changeset" do
      sport = sport_fixture()
      assert %Ecto.Changeset{} = Sports.change_sport(sport)
    end
  end

  describe "games" do
    alias Betsafe.Sports.Game

    import Betsafe.SportsFixtures

    @invalid_attrs %{odds_team_a: nil, odds_team_b: nil, odds_draw: nil, outcome: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Sports.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Sports.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{odds_team_a: 120.5, odds_team_b: 120.5, odds_draw: 120.5, outcome: "some outcome"}

      assert {:ok, %Game{} = game} = Sports.create_game(valid_attrs)
      assert game.odds_team_a == 120.5
      assert game.odds_team_b == 120.5
      assert game.odds_draw == 120.5
      assert game.outcome == "some outcome"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sports.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{odds_team_a: 456.7, odds_team_b: 456.7, odds_draw: 456.7, outcome: "some updated outcome"}

      assert {:ok, %Game{} = game} = Sports.update_game(game, update_attrs)
      assert game.odds_team_a == 456.7
      assert game.odds_team_b == 456.7
      assert game.odds_draw == 456.7
      assert game.outcome == "some updated outcome"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Sports.update_game(game, @invalid_attrs)
      assert game == Sports.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Sports.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Sports.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Sports.change_game(game)
    end
  end
end
