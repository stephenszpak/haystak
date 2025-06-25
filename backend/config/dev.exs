import Config

config :poster_board, PosterBoard.Repo,
  database: "poster_board_dev",
  username: "postgres",
  password: "postgres",
  hostname: "db",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :poster_board, PosterBoardWeb.Endpoint,
  http: [ip: {0,0,0,0}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: System.get_env("SECRET_KEY_BASE") || "SECRET",
  watchers: []

config :phoenix_swagger, PosterBoardWeb.Endpoint,
  swagger_files: %{"priv/static/swagger.json" => [router: PosterBoardWeb.Router]}
