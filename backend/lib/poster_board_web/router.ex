defmodule PosterBoardWeb.Router do
  use PosterBoardWeb, :router

  pipeline :api do
    plug :accepts, ["json", "event-stream"]
  end

  pipeline :auth do
    plug PosterBoardWeb.AuthPlug
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

  scope "/api", PosterBoardWeb do
    pipe_through [:api, :auth]
    get "/me", UserController, :me
    get "/keywords", KeywordController, :index
    post "/keywords", KeywordController, :create
    delete "/keywords/:id", KeywordController, :delete
  end
end
