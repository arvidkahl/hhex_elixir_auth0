defmodule HhexWeb.Router do
  use HhexWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  @doc """
  Attach User object to connection
  """
  def fetch_user(conn, opts) do
    %{"sub" => external_id} = Map.get(conn.assigns, :joken_claims)

    # Actually fetch this from some sort of database
    assign conn, :user, %{
      name: "Test User",
      id: external_id
    }
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Joken.Plug,
      verify: &HhexWeb.JWTHelpers.verify/0,
      on_error: &HhexWeb.JWTHelpers.error/2
    plug :fetch_user
  end

  scope "/", HhexWeb do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
  end

  # Mock API
  scope "/api", HhexWeb do
    pipe_through :api
    get "/", PageController, :api
  end

end
