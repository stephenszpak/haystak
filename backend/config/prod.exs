import Config

database_url = System.get_env("DATABASE_URL") || raise "DATABASE_URL not set"

config :job_hunt, JobHunt.Repo,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base = System.fetch_env!("SECRET_KEY_BASE")

config :job_hunt, JobHuntWeb.Endpoint,
  http: [ip: {0,0,0,0}, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base

config :phoenix_swagger, JobHuntWeb.Endpoint,
  swagger_files: %{"priv/static/swagger.json" => [router: JobHuntWeb.Router]}
