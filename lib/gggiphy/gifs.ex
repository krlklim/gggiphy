defmodule Gggiphy.Gifs do
  @moduledoc """
  The Gifs context.
  """

  import Ecto.Query, warn: false
  alias Gggiphy.Repo

  alias Gggiphy.Gifs.Gif

  @doc """
  Returns the list of gifs.

  ## Examples

      iex> list_gifs()
      [%Gif{}, ...]

  """
  def list_gifs do
    Repo.all(Gif)
  end

  @doc """
  Gets a single gif.

  Raises `Ecto.NoResultsError` if the Gif does not exist.

  ## Examples

      iex> get_gif!(123)
      %Gif{}

      iex> get_gif!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gif!(id), do: Repo.get!(Gif, id)

  def get_gif_by_name!(name) do
    query = from(Gif, where: [name: ^name])
    Repo.all(query)
  end

  def delete_all_records(name) do
    query = from(Gif, where: [name: ^name])
    Repo.delete_all(query)
  end

  @doc """
  Creates a gif.

  ## Examples

      iex> create_gif(%{field: value})
      {:ok, %Gif{}}

      iex> create_gif(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gif(attrs \\ %{}) do
    %Gif{}
    |> Gif.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gif.

  ## Examples

      iex> update_gif(gif, %{field: new_value})
      {:ok, %Gif{}}

      iex> update_gif(gif, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gif(%Gif{} = gif, attrs) do
    gif
    |> Gif.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gif.

  ## Examples

      iex> delete_gif(gif)
      {:ok, %Gif{}}

      iex> delete_gif(gif)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gif(%Gif{} = gif) do
    Repo.delete(gif)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gif changes.

  ## Examples

      iex> change_gif(gif)
      %Ecto.Changeset{data: %Gif{}}

  """
  def change_gif(%Gif{} = gif, attrs \\ %{}) do
    Gif.changeset(gif, attrs)
  end
end
