defmodule TodoApp.TasksTest do
  use TodoApp.DataCase

  alias TodoApp.Tasks

  describe "tasks" do
    alias TodoApp.Tasks.TodoTask

    import TodoApp.TasksFixtures

    @invalid_attrs %{done: nil, name: nil}

    test "list_tasks/0 returns all tasks" do
      todo_task = todo_task_fixture()
      assert Tasks.list_tasks() == [todo_task]
    end

    test "get_todo_task!/1 returns the todo_task with given id" do
      todo_task = todo_task_fixture()
      assert Tasks.get_todo_task!(todo_task.id) == todo_task
    end

    test "create_todo_task/1 with valid data creates a todo_task" do
      valid_attrs = %{done: true, name: "some name"}

      assert {:ok, %TodoTask{} = todo_task} = Tasks.create_todo_task(valid_attrs)
      assert todo_task.done == true
      assert todo_task.name == "some name"
    end

    test "create_todo_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_todo_task(@invalid_attrs)
    end

    test "update_todo_task/2 with valid data updates the todo_task" do
      todo_task = todo_task_fixture()
      update_attrs = %{done: false, name: "some updated name"}

      assert {:ok, %TodoTask{} = todo_task} = Tasks.update_todo_task(todo_task, update_attrs)
      assert todo_task.done == false
      assert todo_task.name == "some updated name"
    end

    test "update_todo_task/2 with invalid data returns error changeset" do
      todo_task = todo_task_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_todo_task(todo_task, @invalid_attrs)
      assert todo_task == Tasks.get_todo_task!(todo_task.id)
    end

    test "delete_todo_task/1 deletes the todo_task" do
      todo_task = todo_task_fixture()
      assert {:ok, %TodoTask{}} = Tasks.delete_todo_task(todo_task)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_todo_task!(todo_task.id) end
    end

    test "change_todo_task/1 returns a todo_task changeset" do
      todo_task = todo_task_fixture()
      assert %Ecto.Changeset{} = Tasks.change_todo_task(todo_task)
    end
  end
end
