defmodule HhexWeb.PageController do
  use HhexWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  def api(conn, _params) do
    render conn, "api.json", %{user: conn.assigns.user}
  end
end
