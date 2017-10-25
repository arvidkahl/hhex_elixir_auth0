defmodule HhexWeb.PageView do
  use HhexWeb, :view

  def render("api.json", %{user: user}) do
    %{
      user: user,
      from_api: true,
    }
  end
end
