import Config

config :job_hunt,
  ecto_repos: [JobHunt.Repo]

config :job_hunt, JobHuntWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: JobHuntWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: JobHunt.PubSub,
  live_view: [signing_salt: "SECRET"]

config :phoenix_swagger, json_library: Jason

config :logger, level: :info

import_config "#{config_env()}.exs"
