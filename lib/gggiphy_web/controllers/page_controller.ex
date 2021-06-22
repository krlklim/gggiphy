defmodule GggiphyWeb.PageController do
  use GggiphyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def get_gifs(conn, _params) do
    giphy_api_key = System.get_env("GIPHY_API_KEY")
    response = HTTPoison.get! "https://api.giphy.com/v1/gifs/search?api_key=#{giphy_api_key}&q=#{_params["searchTerm"]}&limit=20&offset=0&rating=G&lang=en"

    json(conn, response)

  end
end
