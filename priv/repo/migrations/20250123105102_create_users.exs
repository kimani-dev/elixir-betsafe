defmodule Betsafe.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, null: false
      add :last_name, :string
      add :email_address, :string, null: false, unique: true
      add :msisdn, :string
      add :password, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
