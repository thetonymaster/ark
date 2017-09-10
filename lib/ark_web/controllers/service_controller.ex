defmodule ArkWeb.ServiceController do
  use ArkWeb, :controller

  alias Ark.Generator
  alias Ark.Generator.Service

  def index(conn, _params) do
    services = Generator.list_services()
    render(conn, "index.html", services: services)
  end

  def new(conn, _params) do
    changeset = Generator.change_service(%Service{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"service" => service_params}) do
    case Generator.create_service(service_params) do
      {:ok, service} ->
        conn
        |> put_flash(:info, "Service created successfully.")
        |> redirect(to: service_path(conn, :show, service))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    service = Generator.get_service!(id)
    render(conn, "show.html", service: service)
  end

  def edit(conn, %{"id" => id}) do
    service = Generator.get_service!(id)
    changeset = Generator.change_service(service)
    render(conn, "edit.html", service: service, changeset: changeset)
  end

  def update(conn, %{"id" => id, "service" => service_params}) do
    service = Generator.get_service!(id)

    case Generator.update_service(service, service_params) do
      {:ok, service} ->
        conn
        |> put_flash(:info, "Service updated successfully.")
        |> redirect(to: service_path(conn, :show, service))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", service: service, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    service = Generator.get_service!(id)
    {:ok, _service} = Generator.delete_service(service)

    conn
    |> put_flash(:info, "Service deleted successfully.")
    |> redirect(to: service_path(conn, :index))
  end
end
