defmodule PosterBoardWeb.UserController do
  use PosterBoardWeb, :controller
  plug PosterBoardWeb.AuthPlug

  def me(conn, _params) do
    user = conn.assigns.current_user
    json(conn, %{id: user.id, email: user.email})
  end
end
cat > backend/lib/poster_board_web/controllers/keyword_controller.ex
defmodule PosterBoardWeb.KeywordController do
  use PosterBoardWeb, :controller
  alias PosterBoard.Keywords
  plug PosterBoardWeb.AuthPlug

  def index(conn, _params) do
    keywords = Keywords.list_keywords(conn.assigns.current_user)
    json(conn, keywords)
  end

  def create(conn, %{"word" => word}) do
    case Keywords.create_keyword(conn.assigns.current_user, %{word: word}) do
      {:ok, keyword} -> json(conn, keyword)
      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: translate_errors(changeset)})
    end
  end

  def delete(conn, %{"id" => id}) do
    keyword = Keywords.get_keyword!(conn.assigns.current_user, String.to_integer(id))
    {:ok, _} = Keywords.delete_keyword(keyword)
    send_resp(conn, 204, "")
  end

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
