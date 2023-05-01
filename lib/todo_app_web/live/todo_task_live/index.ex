defmodule TodoAppWeb.TodoTaskLive.Index do
  use TodoAppWeb, :live_view

  alias TodoApp.Tasks
  alias TodoApp.Tasks.TodoTask

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:tasks, list_tasks())
      |> assign(:mode, :list),
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Todo task")
    |> assign(:todo_task, Tasks.get_todo_task!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Todo task")
    |> assign(:todo_task, %TodoTask{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tasks")
    |> assign(:todo_task, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    todo_task = Tasks.get_todo_task!(id)
    {:ok, _} = Tasks.delete_todo_task(todo_task)

    {:noreply, assign(socket, :tasks, list_tasks())}
  end

  @impl true
  def handle_event("edit", params, socket) do
    {:noreply, apply_action(socket, :edit, params)}
  end

  defp list_tasks do
    Tasks.list_tasks()
  end
end
