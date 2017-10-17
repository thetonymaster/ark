defmodule ArkWeb.TodoController do
  use ArkWeb, :controller

  import Ecto
  alias Ark.Accounts
  alias Ark.Accounts.Todo

  def index(conn, _params) do
    todos = Accounts.list_todos()
    render(conn, "index.html", todos: todos)
  end

  def new(conn, _params) do
    changeset = Accounts.change_todo(%Todo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo" => todo_params}) do
    changeset = Guardian.Plug.current_resource(conn)
#Doubts in this changes    |> Ecto.build_assoc(:todos)
#Doubts in this changes    |> Ark.Accounts.changeset(todo_params)

    case Accounts.create_todo(todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo created successfully.")
        |> redirect(to: todo_path(conn, :show, todo))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Accounts.get_todo!(id)
    render(conn, "show.html", todo: todo)
  end

    #  def show(conn, %{"id" => id}) do
    #    todo = System.cmd "ls", ["-lha"], into: IO.stream(:stdio, :line)
    #    #todo = Accounts.get_todo!(id)
    #    #    System.cmd "ls", ["-lha"], into: IO.stream(:stdio, :line)
    #    render(conn, "show.html", todo: todo)
    #  end

  def edit(conn, %{"id" => id}) do
    todo = Accounts.get_todo!(id)
    changeset = Accounts.change_todo(todo)
    render(conn, "edit.html", todo: todo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Accounts.get_todo!(id)

    case Accounts.update_todo(todo, todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo updated successfully.")
        |> redirect(to: todo_path(conn, :show, todo))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", todo: todo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Accounts.get_todo!(id)
    {:ok, _todo} = Accounts.delete_todo(todo)

    conn
    |> put_flash(:info, "Todo deleted successfully.")
    |> redirect(to: todo_path(conn, :index))
  end
end
