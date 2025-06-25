import Config

database_url = System.get_env("DATABASE_URL") || "ecto://postgres:postgres@db:5432/poster_board_dev"

config :poster_board, PosterBoard.Repo,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

# secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
secret_key_base = "oogoobooa"

config :poster_board, PosterBoardWeb.Endpoint,
  http: [ip: {0,0,0,0}, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base

config :phoenix_swagger, PosterBoardWeb.Endpoint,
  swagger_files: %{"priv/static/swagger.json" => [router: PosterBoardWeb.Router]}
