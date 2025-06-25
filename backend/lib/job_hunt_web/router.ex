defmodule JobHuntWeb.Router do
  use JobHuntWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JobHuntWeb do
    pipe_through :api
    get "/health", HealthController, :index
  end

  scope "/api", JobHuntWeb do
    pipe_through :api
    get "/swagger", SwaggerController, :swagger_json
  end
end
