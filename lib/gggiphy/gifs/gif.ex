defmodule Gggiphy.Gifs.Gif do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gifs" do
    field :ttl, :naive_datetime
    field :url, :string
    field :images, :map
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(gif, attrs) do
    gif
    |> cast(attrs, [:ttl, :url, :images, :name])
    |> validate_required([:ttl, :url, :images, :name])
  end
end
