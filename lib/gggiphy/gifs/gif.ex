defmodule Gggiphy.Gifs.Gif do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gifs" do
    field :body, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(gif, attrs) do
    gif
    |> cast(attrs, [:name, :body])
    |> validate_required([:name, :body])
  end
end
