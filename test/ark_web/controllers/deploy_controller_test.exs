defmodule ArkWeb.DeployControllerTest do
  use ArkWeb.ConnCase

  alias Ark.Generator

  @create_attrs %{configuration: %{}, terraform_state: %{}}
  @update_attrs %{configuration: %{}, terraform_state: %{}}
  @invalid_attrs %{configuration: nil, terraform_state: nil}

  def fixture(:deploy) do
    {:ok, deploy} = Generator.create_deploy(@create_attrs)
    deploy
  end

  describe "index" do
    test "lists all deploys", %{conn: conn} do
      conn = get conn, deploy_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Deploys"
    end
  end

  describe "new deploy" do
    test "renders form", %{conn: conn} do
      conn = get conn, deploy_path(conn, :new)
      assert html_response(conn, 200) =~ "New Deploy"
    end
  end

  describe "create deploy" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, deploy_path(conn, :create), deploy: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == deploy_path(conn, :show, id)

      conn = get conn, deploy_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Deploy"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, deploy_path(conn, :create), deploy: @invalid_attrs
      assert html_response(conn, 200) =~ "New Deploy"
    end
  end

  describe "edit deploy" do
    setup [:create_deploy]

    test "renders form for editing chosen deploy", %{conn: conn, deploy: deploy} do
      conn = get conn, deploy_path(conn, :edit, deploy)
      assert html_response(conn, 200) =~ "Edit Deploy"
    end
  end

  describe "update deploy" do
    setup [:create_deploy]

    test "redirects when data is valid", %{conn: conn, deploy: deploy} do
      conn = put conn, deploy_path(conn, :update, deploy), deploy: @update_attrs
      assert redirected_to(conn) == deploy_path(conn, :show, deploy)

      conn = get conn, deploy_path(conn, :show, deploy)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, deploy: deploy} do
      conn = put conn, deploy_path(conn, :update, deploy), deploy: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Deploy"
    end
  end

  describe "delete deploy" do
    setup [:create_deploy]

    test "deletes chosen deploy", %{conn: conn, deploy: deploy} do
      conn = delete conn, deploy_path(conn, :delete, deploy)
      assert redirected_to(conn) == deploy_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, deploy_path(conn, :show, deploy)
      end
    end
  end

  defp create_deploy(_) do
    deploy = fixture(:deploy)
    {:ok, deploy: deploy}
  end
end
