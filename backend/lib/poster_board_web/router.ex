defmodule PosterBoardWeb.Router do
  use PosterBoardWeb, :router

  pipeline :api do
    plug :accepts, ["json", "event-stream"]
  end

  scope "/", PosterBoardWeb do
    pipe_through :api
    get "/health", HealthController, :index
  end

  scope "/api", PosterBoardWeb do
    pipe_through :api
    post "/register", AuthController, :register
    post "/login", AuthController, :login
    get "/jobs/stream", JobController, :stream
    get "/swagger", SwaggerController, :swagger_json
  end
end
