defmodule PosterBoardWeb.HealthControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test
  alias PosterBoardWeb.Router

  test "GET /health" do
    conn = conn(:get, "/health")
    conn = Router.call(conn, Router.init([]))
    assert conn.status == 200
  end
end
