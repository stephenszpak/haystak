defmodule PosterBoard.Keywords.Keyword do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:id, :word]}

  schema "keywords" do
    field :word, :string
    belongs_to :user, PosterBoard.Users.User
    timestamps()
  end

  def changeset(keyword, attrs) do
    keyword
    |> cast(attrs, [:word, :user_id])
    |> validate_required([:word, :user_id])
  end
end
