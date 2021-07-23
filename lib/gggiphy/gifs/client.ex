defmodule Gggiphy.Client do
  @moduledoc """
  Parsing json from giphy.
  """
  @limit 100

  def gif_response(_conn, params) do
    giphy_api_key = System.get_env("GIPHY_API_KEY")
    response = HTTPoison.get! "https://api.giphy.com/v1/gifs/search?api_key=#{giphy_api_key}&q=#{params["searchTerm"]}&limit=#{@limit}}&offset=#{Enum.random(1..1000)}&rating=G&lang=en"

    Jason.decode(response.body)
  end
end
