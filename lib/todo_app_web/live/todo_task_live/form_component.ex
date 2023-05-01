defmodule TodoAppWeb.TodoTaskLive.FormComponent do
  use TodoAppWeb, :live_component

  alias TodoApp.Tasks

  @impl true
  def update(%{todo_task: todo_task} = assigns, socket) do
    changeset = Tasks.change_todo_task(todo_task)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"todo_task" => todo_task_params}, socket) do
    changeset =
      socket.assigns.todo_task
      |> Tasks.change_todo_task(todo_task_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"todo_task" => todo_task_params}, socket) do
    save_todo_task(socket, socket.assigns.action, todo_task_params)
  end

  defp save_todo_task(socket, :edit, todo_task_params) do
    case Tasks.update_todo_task(socket.assigns.todo_task, todo_task_params) do
      {:ok, _todo_task} ->
        {:noreply,
         socket
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_todo_task(socket, :new, todo_task_params) do
    case Tasks.create_todo_task(todo_task_params) do
      {:ok, _todo_task} ->
        {:noreply,
         socket
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
