defmodule Betsafe.Bets.Bet do
  alias Betsafe.Bets.Prediction
  use Ecto.Schema
  import Ecto.Changeset

  schema "bets" do
    field :amount, :decimal
    belongs_to :user, Betsafe.Account.User
    has_many :predictions, Prediction

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bet, attrs) do
    bet
    |> cast(attrs, [:amount, :user_id])
    |> put_assoc(:predictions, attrs[:predictions] || [])
    |> validate_required([:amount, :user_id])
  end
end
