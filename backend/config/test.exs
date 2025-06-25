import Config

config :job_hunt, JobHunt.Repo,
  database: "job_hunt_test",
  username: "postgres",
  password: "postgres",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox

config :job_hunt, JobHuntWeb.Endpoint,
  http: [ip: {127,0,0,1}, port: 4002],
  secret_key_base: "SECRET",
  server: false

config :logger, level: :warn
