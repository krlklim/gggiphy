defmodule Gggiphy.Repo.Migrations.CreateGifs do
  use Ecto.Migration

  def change do
    create table(:gifs) do
      add :name, :string
      add :body, :text

      timestamps()
    end

  end
end
