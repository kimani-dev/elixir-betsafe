defmodule Betsafe.Bets.Prediction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "predictions" do
    field :prediction, :string
    belongs_to :bet, Betsafe.Bets.Bet
    belongs_to :game, Betsafe.Sports.Game

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(prediction, attrs) do
    prediction
    |> cast(attrs, [:prediction, :bet_id, :game_id])
    |> validate_required([:prediction, :bet_id, :game_id])
    |> validate_inclusion(:prediction, ["home", "draw", "away"])
  end
end
