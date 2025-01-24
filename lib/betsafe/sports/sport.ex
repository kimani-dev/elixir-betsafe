defmodule Betsafe.Sports.Sport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sports" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sport, attrs) do
    sport
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
