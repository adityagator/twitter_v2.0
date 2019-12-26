defmodule TwitterSim.Repo do
  use Ecto.Repo,
    otp_app: :twitter_sim,
    adapter: Ecto.Adapters.Postgres
end
