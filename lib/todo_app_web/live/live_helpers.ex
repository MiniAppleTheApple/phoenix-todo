defmodule TodoAppWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <.modal return_to={Routes.todo_task_index_path(@socket, :index)}>
        <.live_component
          module={TodoAppWeb.TodoTaskLive.FormComponent}
          id={@todo_task.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.todo_task_index_path(@socket, :index)}
          todo_task: @todo_task
        />
      </.modal>
  """
  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div id="modal" class="my-4" phx-remove={hide_modal()}>
      <div
        id="modal-content"
        phx-click-away={JS.dispatch("click", to: "#close")}
        phx-window-keydown={JS.dispatch("click", to: "#close")}
        phx-key="escape"
      >
        <%= if @return_to do %>
          <%= live_patch "Close",
            to: @return_to,
            id: "close",
            class: "p-2 text-xl font-bold bg-red-500 text-white",
            phx_click: hide_modal()
          %>
        <% else %>
          <a id="close" href="#" class="phx-modal-close" class="p-2 -text-xl font-bold bg-red-500 text-white" phx-click={hide_modal()}>Close</a>
        <% end %>

        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end
end
