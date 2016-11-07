defmodule Chronical.UserController do
  use Chronical.Web, :controller

  def index(conn, _params) do
    users = Repo.all(Chronical.User)
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(Chronical.User, id)
    render conn, "show.html", user: user
  end
end
