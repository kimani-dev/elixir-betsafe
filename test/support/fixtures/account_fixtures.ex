defmodule Betsafe.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Betsafe.Account` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email_address: "some email_address",
        first_name: "some first_name",
        last_name: "some last_name",
        msisdn: "some msisdn",
        password: "some password"
      })
      |> Betsafe.Account.create_user()

    user
  end
end
