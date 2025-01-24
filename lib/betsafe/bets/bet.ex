defmodule Betsafe.Bets.Bet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bets" do
    field :prediction, :string
    field :amount, :decimal

    belongs_to :user, Betsafe.Account.User
    belongs_to :game, Betsafe.Sports.Game

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bet, attrs) do
    bet
    |> cast(attrs, [:prediction, :amount, :user_id, :game_id])
    |> validate_required([:prediction, :amount, :user_id, :game_id])
  end
end
