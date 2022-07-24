defmodule ShortrWeb.LinkLive.Index do
  use ShortrWeb, :live_view

  alias Shortr.Links
  alias Shortr.Links.Link
  alias Shortr.Accounts

  @impl true
  def mount(_params, %{"user_token" => user_token}, socket) do
    user = Accounts.get_user_by_session_token(user_token)

    new_assigns =
      socket
      |> assign(:links, Links.list_links(user.id))
      |> assign(:current_user_id, user.id)

    {:ok, new_assigns}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Link")
    |> assign(:action_label, "Save change")
    |> assign(:link, Links.get_link!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Link")
    |> assign(:action_label, "Shorten link")
    |> assign(:link, %Link{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Links")
    |> assign(:link, nil)
  end

  defp apply_action(socket, :show, %{"id" => id}) do
    socket
    |> assign(:page_title, "Show Link")
    |> assign(:link, Shortr.Metrics.list_visits(id))
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    link = Links.get_link!(id)
    {:ok, _} = Links.delete_link(link)

    {:noreply, assign(socket, :links, Links.list_links(socket.assigns.current_user_id))}
  end
end
