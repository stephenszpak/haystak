defmodule JobHuntWeb.HealthController do
  use JobHuntWeb, :controller

  def index(conn, _params) do
    json(conn, %{status: "ok"})
  end
end
