defmodule PosterBoardWeb.AuthController do
  use PosterBoardWeb, :controller
  alias PosterBoard.Users
  alias PosterBoardWeb.Endpoint

  def register(conn, params) do
    case Users.create_user(params) do
      {:ok, _user} -> json(conn, %{status: "ok"})
      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: translate_errors(changeset)})
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Users.authenticate_user(email, password) do
      {:ok, user} ->
        token = Phoenix.Token.sign(Endpoint, "user salt", user.id)
        json(conn, %{token: token})
      {:error, _} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "invalid_credentials"})
    end
  end

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
