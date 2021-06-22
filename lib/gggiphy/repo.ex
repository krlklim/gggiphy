defmodule Gggiphy.Repo do
  use Ecto.Repo,
    otp_app: :gggiphy,
    adapter: Ecto.Adapters.Postgres
end
