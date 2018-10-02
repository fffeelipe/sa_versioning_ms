defmodule Versioning.Router do
  use Versioning.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Versioning do
    pipe_through :api
    resources "/images", ImageController, except: [:new, :edit, :delete, :index]
    resources "/projects", ProjectController do
      resources "/images", ImageController
    end
    get "/projects/:user/:project/", ProjectController, :index_versions
  end
end
