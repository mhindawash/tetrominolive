defmodule Tetro.Repo do
  use Ecto.Repo,
    otp_app: :freshtet,
    adapter: Ecto.Adapters.Postgres
end
