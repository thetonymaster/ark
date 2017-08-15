defmodule ArkWeb.ApplicationController do
  use ArkWeb, :controller

  alias Ark.Generator
  alias Ark.Generator.Application

  def index(conn, _params) do
    applications = Generator.list_applications()
    render(conn, "index.html", applications: applications)
  end

  def new(conn, _params) do
    changeset = Generator.change_application(%Application{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"application" => application_params}) do
    case Generator.create_application(application_params) do
      {:ok, application} ->
        conn
        |> put_flash(:info, "Application created successfully.")
        |> redirect(to: application_path(conn, :show, application))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    application = Generator.get_application!(id)
    render(conn, "show.html", application: application)
  end

  def edit(conn, %{"id" => id}) do
    application = Generator.get_application!(id)
    changeset = Generator.change_application(application)
    render(conn, "edit.html", application: application, changeset: changeset)
  end

  def update(conn, %{"id" => id, "application" => application_params}) do
    application = Generator.get_application!(id)

    case Generator.update_application(application, application_params) do
      {:ok, application} ->
        conn
        |> put_flash(:info, "Application updated successfully.")
        |> redirect(to: application_path(conn, :show, application))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", application: application, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    application = Generator.get_application!(id)
    {:ok, _application} = Generator.delete_application(application)

    conn
    |> put_flash(:info, "Application deleted successfully.")
    |> redirect(to: application_path(conn, :index))
  end
end
