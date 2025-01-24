defmodule Betsafe.Sports.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :odds_team_a, :float
    field :odds_team_b, :float
    field :odds_draw, :float
    field :outcome, :string

    # relationships
    belongs_to :team_a, Betsafe.Teams.Team
    belongs_to :team_b, Betsafe.Teams.Team
    belongs_to :sport, Betsafe.Sports.Sport

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:odds_team_a, :odds_team_b, :odds_draw, :outcome, :team_a_id, :team_b_id, :sport_id])
    |> validate_required([:odds_team_a, :odds_team_b, :odds_draw, :team_a_id, :team_b_id, :sport_id])
    |> assoc_constraint(:sport)
  end
end
