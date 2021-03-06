use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chronical, Chronical.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Have less hashing rounds to speed up tests
config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1

# Configure your database
config :chronical, Chronical.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DATABASE_POSTGRESQL_USERNAME") || "postgres",
  password: System.get_env("DATABASE_POSTGRESQL_PASSWORD") || "postgres",
  database: "chronical_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
