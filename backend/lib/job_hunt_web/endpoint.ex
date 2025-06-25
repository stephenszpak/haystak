defmodule JobHuntWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :job_hunt

  socket "/socket", Phoenix.LiveView.Socket

  plug Plug.Static,
    at: "/",
    from: :job_hunt,
    gzip: false

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]
  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, store: :cookie, key: "_job_hunt_key", signing_salt: "salt"

  plug JobHuntWeb.Router
end
