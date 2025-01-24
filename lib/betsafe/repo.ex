defmodule Betsafe.Repo do
  use Ecto.Repo,
    otp_app: :betsafe,
    adapter: Ecto.Adapters.Postgres
end
