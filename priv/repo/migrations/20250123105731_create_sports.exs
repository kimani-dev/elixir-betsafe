defmodule Betsafe.Repo.Migrations.CreateSports do
  use Ecto.Migration

  def change do
    create table(:sports) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
