defmodule PosterBoardWeb.UserController do
  use PosterBoardWeb, :controller
  plug PosterBoardWeb.AuthPlug

  def me(conn, _params) do
    user = conn.assigns.current_user
    json(conn, %{id: user.id, email: user.email})
  end
end
