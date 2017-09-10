defmodule ArkWeb.ServiceControllerTest do
  use ArkWeb.ConnCase

  alias Ark.Generator

  @create_attrs %{configuration: %{}, terraform_state: %{}}
  @update_attrs %{configuration: %{}, terraform_state: %{}}
  @invalid_attrs %{configuration: nil, terraform_state: nil}

  def fixture(:service) do
    {:ok, service} = Generator.create_service(@create_attrs)
    service
  end

  describe "index" do
    test "lists all services", %{conn: conn} do
      conn = get conn, service_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Services"
    end
  end

  describe "new service" do
    test "renders form", %{conn: conn} do
      conn = get conn, service_path(conn, :new)
      assert html_response(conn, 200) =~ "New Service"
    end
  end

  describe "create service" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, service_path(conn, :create), service: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == service_path(conn, :show, id)

      conn = get conn, service_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Service"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, service_path(conn, :create), service: @invalid_attrs
      assert html_response(conn, 200) =~ "New Service"
    end
  end

  describe "edit service" do
    setup [:create_service]

    test "renders form for editing chosen service", %{conn: conn, service: service} do
      conn = get conn, service_path(conn, :edit, service)
      assert html_response(conn, 200) =~ "Edit Service"
    end
  end

  describe "update service" do
    setup [:create_service]

    test "redirects when data is valid", %{conn: conn, service: service} do
      conn = put conn, service_path(conn, :update, service), service: @update_attrs
      assert redirected_to(conn) == service_path(conn, :show, service)

      conn = get conn, service_path(conn, :show, service)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, service: service} do
      conn = put conn, service_path(conn, :update, service), service: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Service"
    end
  end

  describe "delete service" do
    setup [:create_service]

    test "deletes chosen service", %{conn: conn, service: service} do
      conn = delete conn, service_path(conn, :delete, service)
      assert redirected_to(conn) == service_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, service_path(conn, :show, service)
      end
    end
  end

  defp create_service(_) do
    service = fixture(:service)
    {:ok, service: service}
  end
end
