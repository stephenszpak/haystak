import Config

config :poster_board,
  ecto_repos: [PosterBoard.Repo]

config :poster_board, PosterBoardWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PosterBoardWeb.ErrorView, accepts: ~w(json), layout: false]
  # LiveView is currently not used. If enabled in the future, configure its
  # signing salt here.
  # live_view: [signing_salt: "SECRET"]

# Register the MIME type used for Server-Sent Events so that
# `plug :accepts, ["json", "event-stream"]` properly negotiates
# requests with the "text/event-stream" header.
config :mime, :types, %{
  "text/event-stream" => ["event-stream"]
}

config :logger, level: :info

import_config "#{config_env()}.exs"
