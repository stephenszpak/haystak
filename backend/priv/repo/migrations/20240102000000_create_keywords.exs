defmodule PosterBoard.Repo.Migrations.CreateKeywords do
  use Ecto.Migration

  def change do
    create table(:keywords) do
      add :word, :string
      add :user_id, references(:users)
      timestamps()
    end

    create index(:keywords, [:user_id])
  end
end
