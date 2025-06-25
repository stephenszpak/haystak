defmodule PosterBoard.Users do
  @moduledoc "User management and authentication"
  alias PosterBoard.Repo
  alias PosterBoard.Users.User

  def get_user(id) when is_integer(id), do: Repo.get(User, id)

  def get_user_by_email(email) when is_binary(email) do
    Repo.get_by(User, email: email)
  end

  def create_user(attrs) do
    %User{}
    |> User.changeset(%{
      email: Map.get(attrs, "email"),
      encrypted_password: hash_password(Map.get(attrs, "password"))
    })
    |> Repo.insert()
  end

  def authenticate_user(email, password) do
    case get_user_by_email(email) do
      nil -> {:error, :invalid_credentials}
      user ->
        if user.encrypted_password == hash_password(password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  def hash_password(password) when is_binary(password) do
    :crypto.hash(:sha256, password) |> Base.encode16(case: :lower)
  end
end
