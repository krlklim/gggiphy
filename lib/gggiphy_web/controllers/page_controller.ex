# TODO: relocate get_gifs logic to another controller

defmodule GggiphyWeb.PageController do
  use GggiphyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  defp fetch_gifs(conn, params) do
    Gggiphy.Gifs.delete_all_records(params["searchTerm"])


    {:ok, json} = Gggiphy.Client.gif_response(conn, params)
    error = Enum.reduce_while(json["data"], :ok, fn gif_url, acc ->
      case Gggiphy.Gifs.create_gif(%{name: params["searchTerm"], url: gif_url["url"], ttl: NaiveDateTime.utc_now, images: gif_url["images"]}) do
        {:ok, _value} ->
          {:count, acc}
        {:error, value} ->
          {:halt, {:error, value}}
      end
    end)

    cond do
      error == :error ->
        json(conn, Jason.encode!(%{"images" => %{"url" => "https://cdn.dribbble.com/users/69313/screenshots/2633467/gif-404.gif"}}))
      true ->
        render_gifs(conn, params)
    end
  end

  def get_gifs(conn, params) do
    cond do
      Enum.random(Gggiphy.Gifs.get_gif_by_name!(params["searchTerm"])) == nil ->
        fetch_gifs(conn, params)
      Enum.random(Gggiphy.Gifs.get_gif_by_name!(params["searchTerm"])) != nil && NaiveDateTime.diff(NaiveDateTime.utc_now, Enum.random(Gggiphy.Gifs.get_gif_by_name!(params["searchTerm"]).ttl)) > 60
        fetch_gifs(conn, params)
      true ->
        render_gifs(conn, params)
    end
  end

  defp render_gifs(conn, params) do
    json(conn, Jason.encode!(Map.get(Enum.random(Gggiphy.Gifs.get_gif_by_name!(params["searchTerm"])), :images)))
  end
end
