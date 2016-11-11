defmodule Chronical.AuthTest do
  use Chronical.ConnCase
  alias Chronical.Auth

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(Chronical.Router, :browser)
      |> get("/")
    {:ok, %{conn: conn}}
  end

  test "login puts the user in the session", %{conn: conn} do
    login_conn =
      conn
      |> Auth.login(%Chronical.User{id: 123})
      |> send_resp(:ok, "")
    next_conn = get(login_conn, "/")
    assert get_session(next_conn, :user_id) == 123
  end

  test "login with a valid username and pass", %{conn: conn} do
    user = insert_user(username: "me", password: "secret")
    {:ok, conn} =
      Auth.login_by_username_and_pass(conn, "me", "secret", repo: Repo)

    assert conn.assigns.current_user.id == user.id
  end

  test "login with a not found user", %{conn: conn} do
    assert {:error, :not_found, _conn} =
      Auth.login_by_username_and_pass(conn, "me", "secret", repo: Repo)
  end

  test "login with password mismatch", %{conn: conn} do
    _ = insert_user(username: "me", password: "secret")

    assert {:error, :unauthorized, _conn} =
      Auth.login_by_username_and_pass(conn, "me", "wrong", repo: Repo)
  end
end
