defmodule Betsafe.Repo.Migrations.CreateBets do
  use Ecto.Migration

  def change do
    create table(:bets) do
      add :prediction, :string
      add :amount, :decimal
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :game_id, references(:games, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:bets, [:user_id])
    create index(:bets, [:game_id])
  end
end
