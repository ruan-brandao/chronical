defmodule Chronical.PageController do
  use Chronical.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
