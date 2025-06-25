defmodule PosterBoard.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :encrypted_password, :string
      timestamps()
    end

    create table(:jobs) do
      add :title, :string
      add :company, :string
      add :url, :string
      timestamps()
    end

    create table(:events) do
      add :title, :string
      add :starts_at, :utc_datetime
      add :ends_at, :utc_datetime
      timestamps()
    end
  end
end
