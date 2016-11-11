defmodule Chronical.PageControllerTest do
  use Chronical.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Chronical!"
  end
end
