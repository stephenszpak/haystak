defmodule PosterBoardWeb.HealthController do
  use PosterBoardWeb, :controller

  def index(conn, _params) do
    json(conn, %{status: "ok"})
  end
end
