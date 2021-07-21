defmodule Gggiphy.Repo.Migrations.CreateGifs do
  use Ecto.Migration

  def change do
    create table(:gifs) do
      add :name, :string
      add :ttl, :naive_datetime
      add :url, :string
      add :images, :map, default: "{}"

      timestamps()
    end

  end
end
