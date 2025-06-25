defmodule PosterBoardWeb.SwaggerController do
  use PosterBoardWeb, :controller

  def swagger_json(conn, _params) do
    swagger_path = Path.join(:code.priv_dir(:poster_board), "static/swagger.json")
    conn
    |> put_resp_content_type("application/json")
    |> send_file(200, swagger_path)
  end
end
