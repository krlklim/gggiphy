defmodule GggiphyWeb.Router do
  use GggiphyWeb, :router

  pipeline :browser do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :csrf do
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GggiphyWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/get_gifs", PageController, :get_gifs
  end

  # Other scopes may use custom stacks.
#   scope "/api", GggiphyWeb do
#     pipe_through :api
#   end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: GggiphyWeb.Telemetry
    end
  end
end
