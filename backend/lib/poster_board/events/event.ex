defmodule PosterBoard.Events.Event do
  @moduledoc """
  Ecto schema representing a calendar event.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :title, :string
    field :starts_at, :utc_datetime
    field :ends_at, :utc_datetime
    timestamps()
  end

  def changeset(event, attrs) do
    event
    |> cast(attrs, [:title, :starts_at, :ends_at])
    |> validate_required([:title, :starts_at])
  end
end
