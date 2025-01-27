defmodule Betsafe.Repo.Migrations.RemoveGameIdFromBets do
  use Ecto.Migration

  def change do
    alter table(:bets) do
      remove :game_id
      remove :prediction
    end
  end
end
