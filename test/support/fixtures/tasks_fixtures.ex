defmodule TodoApp.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoApp.Tasks` context.
  """

  @doc """
  Generate a todo_task.
  """
  def todo_task_fixture(attrs \\ %{}) do
    {:ok, todo_task} =
      attrs
      |> Enum.into(%{
        done: true,
        name: "some name"
      })
      |> TodoApp.Tasks.create_todo_task()

    todo_task
  end
end
