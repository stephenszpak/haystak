defmodule PosterBoardWeb.JobControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test
  alias PosterBoardWeb.Router

  test "GET /api/jobs/stream returns 200" do
    conn = conn(:get, "/api/jobs/stream")
    conn = Router.call(conn, Router.init([]))
    assert conn.status == 200
  end
end
