defmodule Betsafe.BetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Betsafe.Bets` context.
  """

  @doc """
  Generate a bet.
  """
  def bet_fixture(attrs \\ %{}) do
    {:ok, bet} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        prediction: "some prediction"
      })
      |> Betsafe.Bets.create_bet()

    bet
  end
end
