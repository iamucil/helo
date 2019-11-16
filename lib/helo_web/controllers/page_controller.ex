defmodule HeloWeb.PageController do
  use HeloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
