defmodule ShortrWeb.LinkController do
  use ShortrWeb, :controller

  alias Shortr.Links
  alias Shortr.Metrics

  def get_and_redirect(conn, %{"id" => id}) do
    remote_ip =
      Map.get(conn, :remote_ip)
      |> :inet.ntoa()
      |> to_string()

    [agent | _] = Plug.Conn.get_req_header(conn, "user-agent")
    link = Links.get_link!(id)

    Metrics.create_visit(link, agent: agent, ip: remote_ip)

    redirect(conn, external: Map.get(link, :url))
  end
end
