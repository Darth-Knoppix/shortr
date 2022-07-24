defmodule ShortrWeb.MarketingController do
  use ShortrWeb, :controller

  alias Shortr.Links
  alias Shortr.Metrics

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
