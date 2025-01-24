defmodule Betsafe.SportsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Betsafe.Sports` context.
  """

  @doc """
  Generate a sport.
  """
  def sport_fixture(attrs \\ %{}) do
    {:ok, sport} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Betsafe.Sports.create_sport()

    sport
  end

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        odds_draw: 120.5,
        odds_team_a: 120.5,
        odds_team_b: 120.5,
        outcome: "some outcome"
      })
      |> Betsafe.Sports.create_game()

    game
  end
end
