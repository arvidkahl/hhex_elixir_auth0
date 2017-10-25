# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hhex,
  ecto_repos: [Hhex.Repo]

# Configures the endpoint
config :hhex, HhexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ODj9VJliTF59R08ejR3A6UWtRjuzRaTL9lqeqVUOrPGt+lX8E9bLT88/nedslnAY",
  render_errors: [view: HhexWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Hhex.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]



  config :hhex, :auth0,
    app_baseurl: "https://INSERT_YOUR_AUTH0_BASEURL_HERE/",
    app_id: "INSERT_YOUR_AUTH0_ID_HERE",
    app_secret: "INSERT_YOUR_AUTH0_SECRET_HERE"


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
