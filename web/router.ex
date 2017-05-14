defmodule ExRBC.Router do
  use ExRBC.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExRBC do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/casos", CasoController
    get "/query", QueryController, :index
    post "/query", QueryController, :search
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExRBC do
  #   pipe_through :api
  # end
end
