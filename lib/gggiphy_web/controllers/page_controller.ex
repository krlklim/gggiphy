# TODO: relocate get_gifs logic to another controller

defmodule GggiphyWeb.PageController do
  use GggiphyWeb, :controller
  require IEx

  @limit 100

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def fetch_gifs(conn, params) do
    Gggiphy.Gifs.delete_all_records!(params["searchTerm"])

    giphy_api_key = System.get_env("GIPHY_API_KEY")
    response = HTTPoison.get! "https://api.giphy.com/v1/gifs/search?api_key=#{giphy_api_key}&q=#{params["searchTerm"]}&limit=#{@limit}}&offset=#{Enum.random(1..100)}&rating=G&lang=en"

    {:ok, json} = Jason.decode(response.body)
    Enum.each(json["data"], fn gif_url -> Gggiphy.Gifs.create_gif(%{name: params["searchTerm"],
                                                                    url: gif_url["url"],
                                                                    ttl: NaiveDateTime.utc_now,
                                                                    images: gif_url["images"]}) end)
    GggiphyWeb.PageController.render_gifs(conn, params)
  end

  def get_gifs(conn, params) do
    cond do
    (params["searchTerm"]), Enum.random(1..length(Gggiphy.Gifs.list_gifs)-1)
                            |> Gggiphy.Gifs.get_gif_by_name!
                            |> Enum.at == nil ->
        GggiphyWeb.PageController.fetch_gifs(conn, params)
      Enum.at(Gggiphy.Gifs.get_gif_by_name!(params["searchTerm"]), Enum.random(1..length(Gggiphy.Gifs.list_gifs)-1)) != nil && NaiveDateTime.diff(NaiveDateTime.utc_now, Enum.at(Gggiphy.Gifs.get_gif_by_name!(params["searchTerm"]), Enum.random(1..length(Gggiphy.Gifs.list_gifs)-1)).ttl) > 60
        GggiphyWeb.PageController.fetch_gifs(conn, params)
      true ->
        GggiphyWeb.PageController.render_gifs(conn, params)
    end
  end

  def render_gifs(conn, params) do
    json(conn, Jason.encode!(Map.get(Enum.at(Gggiphy.Gifs.get_gif_by_name!(params["searchTerm"]), Enum.random(1..length(Gggiphy.Gifs.get_gif_by_name!(params["searchTerm"]))-1)), :images)))
  end
end
