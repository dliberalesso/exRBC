defmodule ExRBC.PageController do
  use ExRBC.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
