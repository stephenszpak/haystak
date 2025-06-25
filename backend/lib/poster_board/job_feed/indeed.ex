defmodule PosterBoard.JobFeed.Indeed do
  @moduledoc """
  Fetch jobs from Indeed job search.

  This is a best effort HTML scraper and may break if Indeed changes their markup.
  """

  @endpoint "https://www.indeed.com/jobs"

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
    url = @endpoint <> "?q=" <> URI.encode(keywords)

    case Req.get(url) do
      {:ok, %{status: 200, body: body}} -> parse_html(body)
      _ -> []
    end
  end

  defp parse_html(html) do
    {:ok, document} = Floki.parse_document(html)

    document
    |> Floki.find("a.tapItem")
    |> Enum.map(fn a ->
      %{
        title: a |> Floki.find("h2 span") |> Floki.text() |> String.trim(),
        company: a |> Floki.find("span.companyName") |> Floki.text() |> String.trim(),
        location: a |> Floki.find("div.companyLocation") |> Floki.text() |> String.trim(),
        summary: a |> Floki.find("div.job-snippet") |> Floki.text() |> String.trim(),
        url: a |> Floki.attribute("href") |> List.first() |> normalize_url()
      }
    end)
  end

  defp normalize_url(nil), do: nil
  defp normalize_url(url) do
    if String.starts_with?(url, "http") do
      url
    else
      "https://www.indeed.com" <> url
    end
  end
end
