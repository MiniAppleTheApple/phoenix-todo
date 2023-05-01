defmodule TodoApp.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias TodoApp.Repo

  alias TodoApp.Tasks.TodoTask

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%TodoTask{}, ...]

  """
  def list_tasks do
    Repo.all(TodoTask)
  end

  @doc """
  Gets a single todo_task.

  Raises `Ecto.NoResultsError` if the Todo task does not exist.

  ## Examples

      iex> get_todo_task!(123)
      %TodoTask{}

      iex> get_todo_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_todo_task!(id), do: Repo.get!(TodoTask, id)

  @doc """
  Creates a todo_task.

  ## Examples

      iex> create_todo_task(%{field: value})
      {:ok, %TodoTask{}}

      iex> create_todo_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_todo_task(attrs \\ %{}) do
    %TodoTask{}
    |> TodoTask.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a todo_task.

  ## Examples

      iex> update_todo_task(todo_task, %{field: new_value})
      {:ok, %TodoTask{}}

      iex> update_todo_task(todo_task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_todo_task(%TodoTask{} = todo_task, attrs) do
    todo_task
    |> TodoTask.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a todo_task.

  ## Examples

      iex> delete_todo_task(todo_task)
      {:ok, %TodoTask{}}

      iex> delete_todo_task(todo_task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_todo_task(%TodoTask{} = todo_task) do
    Repo.delete(todo_task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo_task changes.

  ## Examples

      iex> change_todo_task(todo_task)
      %Ecto.Changeset{data: %TodoTask{}}

  """
  def change_todo_task(%TodoTask{} = todo_task, attrs \\ %{}) do
    TodoTask.changeset(todo_task, attrs)
  end
end
