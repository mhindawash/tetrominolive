defmodule TetroWeb.PageController do
  use TetroWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
