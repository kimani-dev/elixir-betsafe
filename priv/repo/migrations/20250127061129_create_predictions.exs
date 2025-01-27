defmodule Betsafe.Repo.Migrations.CreatePredictions do
  use Ecto.Migration

  def change do
    create table(:predictions) do
      add :prediction, :string, null: false
      add :bet_id, references(:bets, on_delete: :delete_all), null: false
      add :game_id, references(:games, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:predictions, [:bet_id])
    create index(:predictions, [:game_id])
  end
end
