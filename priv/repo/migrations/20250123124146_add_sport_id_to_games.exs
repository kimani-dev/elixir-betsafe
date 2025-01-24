defmodule Betsafe.Repo.Migrations.AddSportIdToGames do
  use Ecto.Migration

  def change do
    alter table(:games) do
      add :sport_id, references(:sports, on_delete: :nothing), null: true
    end

    create index(:games, [:sport_id])
  end
end
