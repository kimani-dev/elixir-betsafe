defmodule Betsafe.TeamsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Betsafe.Teams` context.
  """

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Betsafe.Teams.create_team()

    team
  end
end
