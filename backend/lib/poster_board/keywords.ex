defmodule PosterBoard.Keywords do
  @moduledoc "Manage user search keywords"
  import Ecto.Query
  alias PosterBoard.Keywords.Keyword
  alias PosterBoard.Repo
  alias PosterBoard.Users.User

  def list_keywords(%User{id: user_id}) do
    Repo.all(from k in Keyword, where: k.user_id == ^user_id)
  end

  def get_keyword!(%User{id: user_id}, id) do
    Repo.get_by!(Keyword, id: id, user_id: user_id)
  end

  def create_keyword(%User{id: user_id}, attrs) do
    %Keyword{user_id: user_id}
    |> Keyword.changeset(attrs)
    |> Repo.insert()
  end

  def delete_keyword(%Keyword{} = keyword) do
    Repo.delete(keyword)
  end
end
