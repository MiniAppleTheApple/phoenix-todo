defmodule TodoAppWeb.TodoTaskLiveTest do
  use TodoAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import TodoApp.TasksFixtures

  @create_attrs %{done: true, name: "some name"}
  @update_attrs %{done: false, name: "some updated name"}
  @invalid_attrs %{done: false, name: nil}

  defp create_todo_task(_) do
    todo_task = todo_task_fixture()
    %{todo_task: todo_task}
  end

  describe "Index" do
    setup [:create_todo_task]

    test "lists all tasks", %{conn: conn, todo_task: todo_task} do
      {:ok, _index_live, html} = live(conn, Routes.todo_task_index_path(conn, :index))

      assert html =~ "Listing Tasks"
      assert html =~ todo_task.name
    end

    test "saves new todo_task", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.todo_task_index_path(conn, :index))

      assert index_live |> element("a", "New Todo task") |> render_click() =~
               "New Todo task"

      assert_patch(index_live, Routes.todo_task_index_path(conn, :new))

      assert index_live
             |> form("#todo_task-form", todo_task: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#todo_task-form", todo_task: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.todo_task_index_path(conn, :index))

      assert html =~ "Todo task created successfully"
      assert html =~ "some name"
    end

    test "updates todo_task in listing", %{conn: conn, todo_task: todo_task} do
      {:ok, index_live, _html} = live(conn, Routes.todo_task_index_path(conn, :index))

      assert index_live |> element("#todo_task-#{todo_task.id} a", "Edit") |> render_click() =~
               "Edit Todo task"

      assert_patch(index_live, Routes.todo_task_index_path(conn, :edit, todo_task))

      assert index_live
             |> form("#todo_task-form", todo_task: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#todo_task-form", todo_task: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.todo_task_index_path(conn, :index))

      assert html =~ "Todo task updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes todo_task in listing", %{conn: conn, todo_task: todo_task} do
      {:ok, index_live, _html} = live(conn, Routes.todo_task_index_path(conn, :index))

      assert index_live |> element("#todo_task-#{todo_task.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#todo_task-#{todo_task.id}")
    end
  end

  describe "Show" do
    setup [:create_todo_task]

    test "displays todo_task", %{conn: conn, todo_task: todo_task} do
      {:ok, _show_live, html} = live(conn, Routes.todo_task_show_path(conn, :show, todo_task))

      assert html =~ "Show Todo task"
      assert html =~ todo_task.name
    end

    test "updates todo_task within modal", %{conn: conn, todo_task: todo_task} do
      {:ok, show_live, _html} = live(conn, Routes.todo_task_show_path(conn, :show, todo_task))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Todo task"

      assert_patch(show_live, Routes.todo_task_show_path(conn, :edit, todo_task))

      assert show_live
             |> form("#todo_task-form", todo_task: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#todo_task-form", todo_task: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.todo_task_show_path(conn, :show, todo_task))

      assert html =~ "Todo task updated successfully"
      assert html =~ "some updated name"
    end
  end
end
