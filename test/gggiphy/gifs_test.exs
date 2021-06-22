defmodule Gggiphy.GifsTest do
  use Gggiphy.DataCase

  alias Gggiphy.Gifs

  describe "gifs" do
    alias Gggiphy.Gifs.Gif

    @valid_attrs %{body: "some body", name: "some name"}
    @update_attrs %{body: "some updated body", name: "some updated name"}
    @invalid_attrs %{body: nil, name: nil}

    def gif_fixture(attrs \\ %{}) do
      {:ok, gif} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Gifs.create_gif()

      gif
    end

    test "list_gifs/0 returns all gifs" do
      gif = gif_fixture()
      assert Gifs.list_gifs() == [gif]
    end

    test "get_gif!/1 returns the gif with given id" do
      gif = gif_fixture()
      assert Gifs.get_gif!(gif.id) == gif
    end

    test "create_gif/1 with valid data creates a gif" do
      assert {:ok, %Gif{} = gif} = Gifs.create_gif(@valid_attrs)
      assert gif.body == "some body"
      assert gif.name == "some name"
    end

    test "create_gif/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Gifs.create_gif(@invalid_attrs)
    end

    test "update_gif/2 with valid data updates the gif" do
      gif = gif_fixture()
      assert {:ok, %Gif{} = gif} = Gifs.update_gif(gif, @update_attrs)
      assert gif.body == "some updated body"
      assert gif.name == "some updated name"
    end

    test "update_gif/2 with invalid data returns error changeset" do
      gif = gif_fixture()
      assert {:error, %Ecto.Changeset{}} = Gifs.update_gif(gif, @invalid_attrs)
      assert gif == Gifs.get_gif!(gif.id)
    end

    test "delete_gif/1 deletes the gif" do
      gif = gif_fixture()
      assert {:ok, %Gif{}} = Gifs.delete_gif(gif)
      assert_raise Ecto.NoResultsError, fn -> Gifs.get_gif!(gif.id) end
    end

    test "change_gif/1 returns a gif changeset" do
      gif = gif_fixture()
      assert %Ecto.Changeset{} = Gifs.change_gif(gif)
    end
  end
end
