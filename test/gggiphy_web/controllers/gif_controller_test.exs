defmodule GggiphyWeb.GifControllerTest do
  use GggiphyWeb.ConnCase

  alias Gggiphy.Gifs

  @create_attrs %{body: "some body", name: "some name"}
  @update_attrs %{body: "some updated body", name: "some updated name"}
  @invalid_attrs %{body: nil, name: nil}

  def fixture(:gif) do
    {:ok, gif} = Gifs.create_gif(@create_attrs)
    gif
  end

  describe "index" do
    test "lists all gifs", %{conn: conn} do
      conn = get(conn, Routes.gif_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Gifs"
    end
  end

  describe "new gif" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.gif_path(conn, :new))
      assert html_response(conn, 200) =~ "New Gif"
    end
  end

  describe "create gif" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.gif_path(conn, :create), gif: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.gif_path(conn, :show, id)

      conn = get(conn, Routes.gif_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Gif"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.gif_path(conn, :create), gif: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Gif"
    end
  end

  describe "edit gif" do
    setup [:create_gif]

    test "renders form for editing chosen gif", %{conn: conn, gif: gif} do
      conn = get(conn, Routes.gif_path(conn, :edit, gif))
      assert html_response(conn, 200) =~ "Edit Gif"
    end
  end

  describe "update gif" do
    setup [:create_gif]

    test "redirects when data is valid", %{conn: conn, gif: gif} do
      conn = put(conn, Routes.gif_path(conn, :update, gif), gif: @update_attrs)
      assert redirected_to(conn) == Routes.gif_path(conn, :show, gif)

      conn = get(conn, Routes.gif_path(conn, :show, gif))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, gif: gif} do
      conn = put(conn, Routes.gif_path(conn, :update, gif), gif: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Gif"
    end
  end

  describe "delete gif" do
    setup [:create_gif]

    test "deletes chosen gif", %{conn: conn, gif: gif} do
      conn = delete(conn, Routes.gif_path(conn, :delete, gif))
      assert redirected_to(conn) == Routes.gif_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.gif_path(conn, :show, gif))
      end
    end
  end

  defp create_gif(_) do
    gif = fixture(:gif)
    %{gif: gif}
  end
end
