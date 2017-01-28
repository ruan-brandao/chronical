defmodule Chronical.Router do
  use Chronical.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Chronical.Auth, repo: Chronical.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Chronical do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :new, :show, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/create", Chronical do
    pipe_through [:browser, :authenticate_user]

    resources "/stories", StoryController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Chronical do
  #   pipe_through :api
  # end
end
