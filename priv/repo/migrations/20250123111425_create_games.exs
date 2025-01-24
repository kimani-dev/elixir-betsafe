defmodule Betsafe.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :odds_team_a, :float
      add :odds_team_b, :float
      add :odds_draw, :float
      add :outcome, :string
      add :team_a_id, references(:teams, on_delete: :nothing), null: false
      add :team_b_id, references(:teams, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:games, [:team_a_id])
    create index(:games, [:team_b_id])
  end
end
