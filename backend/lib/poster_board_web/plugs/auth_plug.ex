defmodule PosterBoardWeb.AuthPlug do
  @moduledoc """
  Plug for authenticating API requests.
  """
  import Plug.Conn
  alias PosterBoard.Users
  alias PosterBoardWeb.Endpoint

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user_id} <- Phoenix.Token.verify(Endpoint, "user salt", token, max_age: 14 * 24 * 3600),
         user when not is_nil(user) <- Users.get_user(user_id) do
      assign(conn, :current_user, user)
    else
      _ ->
        conn
        |> send_resp(401, "unauthorized")
        |> halt()
    end
  end
end
