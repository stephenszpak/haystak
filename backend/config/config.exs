import Config

config :poster_board,
  ecto_repos: [PosterBoard.Repo]

config :poster_board, PosterBoardWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PosterBoardWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PosterBoard.PubSub
  # LiveView is currently not used. If enabled in the future, configure its
  # signing salt here.
  # live_view: [signing_salt: "SECRET"]

config :phoenix_swagger, json_library: Jason

config :logger, level: :info

import_config "#{config_env()}.exs"
