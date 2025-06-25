defmodule PosterBoardWeb.Router do
  use PosterBoardWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PosterBoardWeb do
    pipe_through :api
    get "/health", HealthController, :index
  end

  scope "/api", PosterBoardWeb do
    pipe_through :api
    post "/register", AuthController, :register
    post "/login", AuthController, :login
    get "/swagger", SwaggerController, :swagger_json
  end
end
