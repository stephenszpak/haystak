defmodule PosterBoardWeb.JobController do
  @moduledoc """
  Handles job related HTTP actions.
  """
  use PosterBoardWeb, :controller
  alias PosterBoard.JobFeed.{Glassdoor, Indeed, LinkedIn}

  @doc """
  Stream job postings from multiple sources using Server-Sent Events (SSE).

  Optional query parameter `keywords` may be provided as a comma separated list
  which will be used to filter the results. If no keywords are supplied,
  a default search for software and web development jobs is used.
  """
  def stream(conn, params) do
    keywords =
      params
      |> Map.get("keywords", "")
      |> String.split(",", trim: true)
      |> default_keywords()

    jobs =
      LinkedIn.fetch_jobs(keywords) ++
        Indeed.fetch_jobs(keywords) ++
        Glassdoor.fetch_jobs(keywords)

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

  defp default_keywords([]), do: ["software development", "web development"]
  defp default_keywords(list), do: list
end
