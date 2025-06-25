defmodule PosterBoardWeb.JobController do
  use PosterBoardWeb, :controller

  @doc """
  Stream job postings using Server-Sent Events (SSE).
  Currently streams a placeholder event so the endpoint exists
  without returning a 404.
  """
  def stream(conn, _params) do
    conn =
      conn
      |> put_resp_header("cache-control", "no-cache")
      |> put_resp_header("content-type", "text/event-stream")
      |> send_chunked(200)

    # send an empty JSON object as a placeholder event
    _ = chunk(conn, "data: {}\n\n")
    conn
  end
end
