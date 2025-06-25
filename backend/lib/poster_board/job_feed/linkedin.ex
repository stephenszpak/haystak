defmodule PosterBoard.JobFeed.LinkedIn do
  @moduledoc """
  Fetch jobs from LinkedIn job search.

  This implementation uses LinkedIn's public job search endpoint and parses the
  resulting HTML to extract job information. It should be considered a best
  effort placeholder and may break if LinkedIn changes their markup.
  """

  @endpoint "https://www.linkedin.com/jobs-guest/jobs/api/seeMoreJobPostings/search"

  @doc """
  Fetch jobs matching the given keywords.

  `keywords` can be either a list of words or a single string. Returns a list of
  maps with `:title`, `:company` and `:url` keys.
  """
  def fetch_jobs(keywords) when is_list(keywords) do
    keywords
    |> Enum.join(" ")
    |> fetch_jobs()
  end

  def fetch_jobs(keywords) when is_binary(keywords) do
    url = @endpoint <> "?keywords=" <> URI.encode(keywords)

    with {:ok, %{status: 200, body: body}} <- Req.get(url) do
      parse_html(body)
    else
      _ -> []
    end
  end

  defp parse_html(html) do
    {:ok, document} = Floki.parse_document(html)

    document
    |> Floki.find("li")
    |> Enum.map(fn li ->
      %{
        title: li |> Floki.find("h3") |> Floki.text() |> String.trim(),
        company: li |> Floki.find(".base-search-card__subtitle") |> Floki.text() |> String.trim(),
        url: li |> Floki.find("a") |> Floki.attribute("href") |> List.first()
      }
    end)
  end
end
