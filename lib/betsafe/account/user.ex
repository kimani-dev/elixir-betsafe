defmodule Betsafe.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :password, :string
    field :first_name, :string
    field :last_name, :string
    field :email_address, :string
    field :msisdn, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email_address, :msisdn, :password])
    |> validate_required([:first_name, :email_address, :password])
  end
end
