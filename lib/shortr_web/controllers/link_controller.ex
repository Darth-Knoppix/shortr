defmodule ShortrWeb.LinkController do
  use ShortrWeb, :controller
  alias Shortr.Links

  def get_and_redirect(conn, %{"id" => id}) do
    url =
      id
      |> Links.get_link!()
      |> Map.get(:url)

    redirect(conn, external: url)
  end
end
