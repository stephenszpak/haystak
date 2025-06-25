defmodule PosterBoardWeb.JobController do
  use PosterBoardWeb, :controller

  @doc """
  Stream job postings from LinkedIn using Server-Sent Events (SSE).

  Optional query parameter `keywords` may be provided as a comma separated list
  which will be used to filter LinkedIn results.
  """
  def stream(conn, params) do
    keywords =
      params
      |> Map.get("keywords", "")
      |> String.split(",", trim: true)

    jobs = PosterBoard.JobFeed.LinkedIn.fetch_jobs(keywords)

    conn =
      conn
      |> put_resp_header("cache-control", "no-cache")
      |> put_resp_header("content-type", "text/event-stream")
      |> send_chunked(200)

    Enum.reduce_while(jobs, conn, fn job, conn ->
      payload = "data: " <> Jason.encode!(job) <> "\n\n"
      case chunk(conn, payload) do
        {:ok, conn} -> {:cont, conn}
        {:error, _} -> {:halt, conn}
      end
    end)
  end
end
