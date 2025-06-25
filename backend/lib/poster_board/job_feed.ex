defmodule PosterBoard.JobFeed do
  @moduledoc """
  Polls external job boards and streams new postings.
  """

  alias PosterBoard.JobFeed.{Glassdoor, Indeed, LinkedIn}

  @doc """
  Poll all known job sources and return a combined list of jobs.
  """
  def poll_all(keywords \\ []) do
    LinkedIn.fetch_jobs(keywords) ++
      Indeed.fetch_jobs(keywords) ++
      Glassdoor.fetch_jobs(keywords)
  end
end
