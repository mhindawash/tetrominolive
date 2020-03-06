defmodule Tetro.Repo do
  use Ecto.Repo,
    otp_app: :tetro,
    adapter: Ecto.Adapters.Postgres
end
