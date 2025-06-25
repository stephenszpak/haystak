defmodule PosterBoard.JobFeed.Glassdoor do
  @moduledoc """
  Fetch jobs from Glassdoor job search.

  This is a best effort HTML scraper and may break if Glassdoor changes their markup.
  """

  @endpoint "https://www.glassdoor.com/Job/jobs.htm"

  @doc """
  Fetch jobs matching the given keywords.
  Returns a list of maps with `:title`, `:company`, `:location`, `:summary` and `:url` keys.
  """
  def fetch_jobs(keywords) when is_list(keywords) do
    keywords
    |> Enum.join(" ")
    |> fetch_jobs()
  end

  def fetch_jobs(keywords) when is_binary(keywords) do
    url = @endpoint <> "?sc.keyword=" <> URI.encode(keywords)

    case Req.get(url) do
      {:ok, %{status: 200, body: body}} -> parse_html(body)
      _ -> []
    end
  end

  defp parse_html(html) do
    {:ok, document} = Floki.parse_document(html)

    document
    |> Floki.find("li.react-job-listing")
    |> Enum.map(fn li ->
      %{
        title: li |> Floki.find("a.jobLink") |> Floki.text() |> String.trim(),
        company: li |> Floki.find(".job-search-1cbsw2k") |> Floki.text() |> String.trim(),
        location: li |> Floki.find(".job-search-1v2wdoj") |> Floki.text() |> String.trim(),
        summary: li |> Floki.find(".job-snippet") |> Floki.text() |> String.trim(),
        url: li |> Floki.find("a.jobLink") |> Floki.attribute("href") |> List.first() |> normalize_url()
      }
    end)
  end

  defp normalize_url(nil), do: nil
  defp normalize_url(url) do
    if String.starts_with?(url, "http") do
      url
    else
      "https://www.glassdoor.com" <> url
    end
  end
end
