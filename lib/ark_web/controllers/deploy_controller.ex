defmodule ArkWeb.DeployController do
  use ArkWeb, :controller

  alias Ark.Generator
  alias Ark.Generator.Deploy

  def index(conn, _params) do
    deploys = Generator.list_deploys()
    render(conn, "index.html", deploys: deploys)
  end

  def new(conn, _params) do
    changeset = Generator.change_deploy(%Deploy{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"deploy" => deploy_params}) do
    case Generator.create_deploy(deploy_params) do
      {:ok, deploy} ->
        conn
        |> put_flash(:info, "Deploy created successfully.")
        |> redirect(to: deploy_path(conn, :show, deploy))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    deploy = Generator.get_deploy!(id)
    render(conn, "show.html", deploy: deploy)
  end

  def edit(conn, %{"id" => id}) do
    deploy = Generator.get_deploy!(id)
    changeset = Generator.change_deploy(deploy)
    render(conn, "edit.html", deploy: deploy, changeset: changeset)
  end

  def update(conn, %{"id" => id, "deploy" => deploy_params}) do
    deploy = Generator.get_deploy!(id)

    case Generator.update_deploy(deploy, deploy_params) do
      {:ok, deploy} ->
        conn
        |> put_flash(:info, "Deploy updated successfully.")
        |> redirect(to: deploy_path(conn, :show, deploy))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", deploy: deploy, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    deploy = Generator.get_deploy!(id)
    {:ok, _deploy} = Generator.delete_deploy(deploy)

    conn
    |> put_flash(:info, "Deploy deleted successfully.")
    |> redirect(to: deploy_path(conn, :index))
  end
end
