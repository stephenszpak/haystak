defmodule PosterBoardWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :poster_board

  # The LiveView socket is disabled since we do not use LiveView in this
  # project. If needed in the future, uncomment the line below.
  # socket "/socket", Phoenix.LiveView.Socket

  plug Plug.Static,
    at: "/",
    from: :poster_board,
    gzip: false

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]
  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, store: :cookie, key: "_poster_board_key", signing_salt: "salt"

  plug PosterBoardWeb.Router
end
