defmodule GggiphyWeb.FetchControllerTest do
  use GggiphyWeb.ConnCase

  alias Gggiphy.Fetches

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:fetch) do
    {:ok, fetch} = Fetches.create_fetch(@create_attrs)
    fetch
  end

  describe "index" do
    test "lists all fetches", %{conn: conn} do
      conn = get(conn, Routes.fetch_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Fetches"
    end
  end

  describe "new fetch" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.fetch_path(conn, :new))
      assert html_response(conn, 200) =~ "New Fetch"
    end
  end

  describe "create fetch" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.fetch_path(conn, :create), fetch: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.fetch_path(conn, :show, id)

      conn = get(conn, Routes.fetch_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Fetch"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.fetch_path(conn, :create), fetch: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Fetch"
    end
  end

  describe "edit fetch" do
    setup [:create_fetch]

    test "renders form for editing chosen fetch", %{conn: conn, fetch: fetch} do
      conn = get(conn, Routes.fetch_path(conn, :edit, fetch))
      assert html_response(conn, 200) =~ "Edit Fetch"
    end
  end

  describe "update fetch" do
    setup [:create_fetch]

    test "redirects when data is valid", %{conn: conn, fetch: fetch} do
      conn = put(conn, Routes.fetch_path(conn, :update, fetch), fetch: @update_attrs)
      assert redirected_to(conn) == Routes.fetch_path(conn, :show, fetch)

      conn = get(conn, Routes.fetch_path(conn, :show, fetch))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, fetch: fetch} do
      conn = put(conn, Routes.fetch_path(conn, :update, fetch), fetch: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Fetch"
    end
  end

  describe "delete fetch" do
    setup [:create_fetch]

    test "deletes chosen fetch", %{conn: conn, fetch: fetch} do
      conn = delete(conn, Routes.fetch_path(conn, :delete, fetch))
      assert redirected_to(conn) == Routes.fetch_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.fetch_path(conn, :show, fetch))
      end
    end
  end

  defp create_fetch(_) do
    fetch = fixture(:fetch)
    %{fetch: fetch}
  end
end
