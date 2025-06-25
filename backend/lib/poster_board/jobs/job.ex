defmodule PosterBoard.Jobs.Job do
  @moduledoc """
  Ecto schema representing a job posting.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :title, :string
    field :company, :string
    field :url, :string
    timestamps()
  end

  def changeset(job, attrs) do
    job
    |> cast(attrs, [:title, :company, :url])
    |> validate_required([:title, :company])
  end
end
