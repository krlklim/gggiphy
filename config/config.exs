# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gggiphy,
  ecto_repos: [Gggiphy.Repo]

# Configures the endpoint
config :gggiphy, GggiphyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EMm6WTCC0g23QKA//3gxDEELhyUKoi9a4XQczPL9PzW2KAwsE2mO3QDlOWQoLtJv",
  render_errors: [view: GggiphyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Gggiphy.PubSub,
  live_view: [signing_salt: "EXRIIHC8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
