defmodule JobHuntWeb.SwaggerController do
  use JobHuntWeb, :controller

  def swagger_json(conn, _params) do
    swagger_path = Path.join(:code.priv_dir(:job_hunt), "static/swagger.json")
    conn
    |> put_resp_content_type("application/json")
    |> send_file(200, swagger_path)
  end
end
