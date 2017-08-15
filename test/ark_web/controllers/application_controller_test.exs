defmodule ArkWeb.ApplicationControllerTest do
  use ArkWeb.ConnCase

  alias Ark.Generator

  @create_attrs %{description: "some description", logo: "some logo", name: "some name", template: "some template"}
  @update_attrs %{description: "some updated description", logo: "some updated logo", name: "some updated name", template: "some updated template"}
  @invalid_attrs %{description: nil, logo: nil, name: nil, template: nil}

  def fixture(:application) do
    {:ok, application} = Generator.create_application(@create_attrs)
    application
  end

  describe "index" do
    test "lists all applications", %{conn: conn} do
      conn = get conn, application_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Applications"
    end
  end

  describe "new application" do
    test "renders form", %{conn: conn} do
      conn = get conn, application_path(conn, :new)
      assert html_response(conn, 200) =~ "New Application"
    end
  end

  describe "create application" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, application_path(conn, :create), application: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == application_path(conn, :show, id)

      conn = get conn, application_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Application"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, application_path(conn, :create), application: @invalid_attrs
      assert html_response(conn, 200) =~ "New Application"
    end
  end

  describe "edit application" do
    setup [:create_application]

    test "renders form for editing chosen application", %{conn: conn, application: application} do
      conn = get conn, application_path(conn, :edit, application)
      assert html_response(conn, 200) =~ "Edit Application"
    end
  end

  describe "update application" do
    setup [:create_application]

    test "redirects when data is valid", %{conn: conn, application: application} do
      conn = put conn, application_path(conn, :update, application), application: @update_attrs
      assert redirected_to(conn) == application_path(conn, :show, application)

      conn = get conn, application_path(conn, :show, application)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, application: application} do
      conn = put conn, application_path(conn, :update, application), application: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Application"
    end
  end

  describe "delete application" do
    setup [:create_application]

    test "deletes chosen application", %{conn: conn, application: application} do
      conn = delete conn, application_path(conn, :delete, application)
      assert redirected_to(conn) == application_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, application_path(conn, :show, application)
      end
    end
  end

  defp create_application(_) do
    application = fixture(:application)
    {:ok, application: application}
  end
end
