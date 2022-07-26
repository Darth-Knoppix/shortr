defmodule ShortrWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <.modal return_to={Routes.link_index_path(@socket, :index)}>
        <.live_component
          module={ShortrWeb.LinkLive.FormComponent}
          id={@link.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.link_index_path(@socket, :index)}
          link: @link
        />
      </.modal>
  """
  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div id="modal" class="modal modal-open fade-in" phx-remove={hide_modal()}>
      <div
        id="modal-content"
        class="modal-box relative bg-slate-100 dark:bg-slate-900"
        phx-click-away={JS.dispatch("click", to: "#close")}
        phx-window-keydown={JS.dispatch("click", to: "#close")}
        phx-key="escape"
      >
        <%= if @return_to do %>
          <%= live_patch to: @return_to,
            id: "close",
            class: "btn btn-square absolute right-2 top-2",
            phx_click: hide_modal() do
          %>
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" /></svg>
          <% end %>
        <% else %>
          <a id="close" href="#" class="btn btn-square absolute right-2 top-2" phx-click={hide_modal()}>
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" /></svg>
          </a>
        <% end %>

        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content")
  end

  def drawer(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div class="drawer drawer-end">
    <div class="drawer-side">
      <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end
end
