defmodule ShortrWeb.MarketingController do
  use ShortrWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
