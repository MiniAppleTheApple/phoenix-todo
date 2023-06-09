defmodule TodoApp.TodoTask do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :done, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(todo_task, attrs) do
    todo_task
    |> cast(attrs, [:name, :done])
    |> validate_required([:name, :done])
  end
end
