import Config

config :poster_board, PosterBoard.Repo,
  database: "poster_board_test",
  username: "postgres",
  password: "postgres",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox

config :poster_board, PosterBoardWeb.Endpoint,
  http: [ip: {127,0,0,1}, port: 4002],
  secret_key_base: "SECRET",
  server: false

config :logger, level: :warn
