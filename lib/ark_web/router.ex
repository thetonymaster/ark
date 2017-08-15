defmodule ArkWeb.Router do
  use ArkWeb, :router

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

  scope "/", ArkWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/applications", ApplicationController
    resources "/deploys", DeployController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ArkWeb do
  #   pipe_through :api
  # end
end
