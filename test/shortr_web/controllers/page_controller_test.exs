defmodule ShortrWeb.PageControllerTest do
  use ShortrWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Let's shorten some links!"
  end
end
