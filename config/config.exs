# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ark,
  ecto_repos: [Ark.Repo]

# Configures the endpoint
config :ark, ArkWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ny/tl80Z3QVU+ZlWVMZjeSFnfgNz8eF/oY1iuaRH2kbFeioTVfARbU5/3zt61LUD",
  render_errors: [view: ArkWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ark.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
