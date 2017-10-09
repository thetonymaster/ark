defmodule ArkWeb.Router do
  use ArkWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.VerifyHeader
    #    plug Guardian.Plug.EnsureAuthenticated , handler: Ark.Token
    plug Guardian.Plug.LoadResource
  end

   pipeline :ensure_authed_access do
       plug Guardian.Plug.EnsureAuthenticated,handler: Ark.HttpErrorHandler
   end  

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ArkWeb do
    pipe_through [:browser,:browser_auth] # Use the default browser stack

    #    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/", ArkWeb do
  pipe_through [:browser, :browser_auth,:ensure_authed_access]
  get "/", PageController, :index
        resources "/applications", ApplicationController
        resources "/services", ServiceController
        resources "/credentials", CredentialController
        resources "/users", UserController
        resources "/sessions", SessionController, only: [:new, :create, :delete]
        resources "/todos", TodoController
        resources "/roles", RoleController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ArkWeb do
  #   pipe_through :api
  #end
end
