defmodule Ark.GeneratorTest do
  use Ark.DataCase

  alias Ark.Generator

  describe "applications" do
    alias Ark.Generator.Application

    @valid_attrs %{description: "some description", logo: "some logo", name: "some name", files: "some files"}
    @update_attrs %{description: "some updated description", logo: "some updated logo", name: "some updated name", files: "some updated files"}
    @invalid_attrs %{description: nil, logo: nil, name: nil, files: nil}

    def application_fixture(attrs \\ %{}) do
      {:ok, application} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Generator.create_application()

      application
    end

    test "list_applications/0 returns all applications" do
      application = application_fixture()
      assert Generator.list_applications() == [application]
    end

    test "get_application!/1 returns the application with given id" do
      application = application_fixture()
      assert Generator.get_application!(application.id) == application
    end

    test "create_application/1 with valid data creates a application" do
      assert {:ok, %Application{} = application} = Generator.create_application(@valid_attrs)
      assert application.description == "some description"
      assert application.logo == "some logo"
      assert application.name == "some name"
      assert application.files == "some files"
    end

    test "create_application/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Generator.create_application(@invalid_attrs)
    end

    test "update_application/2 with valid data updates the application" do
      application = application_fixture()
      assert {:ok, application} = Generator.update_application(application, @update_attrs)
      assert %Application{} = application
      assert application.description == "some updated description"
      assert application.logo == "some updated logo"
      assert application.name == "some updated name"
      assert application.files == "some updated files"
    end

    test "update_application/2 with invalid data returns error changeset" do
      application = application_fixture()
      assert {:error, %Ecto.Changeset{}} = Generator.update_application(application, @invalid_attrs)
      assert application == Generator.get_application!(application.id)
    end

    test "delete_application/1 deletes the application" do
      application = application_fixture()
      assert {:ok, %Application{}} = Generator.delete_application(application)
      assert_raise Ecto.NoResultsError, fn -> Generator.get_application!(application.id) end
    end

    test "change_application/1 returns a application changeset" do
      application = application_fixture()
      assert %Ecto.Changeset{} = Generator.change_application(application)
    end
  end

  describe "services" do
    alias Ark.Generator.Service

    @valid_attrs %{configuration: %{}, terraform_state: %{}}
    @update_attrs %{configuration: %{}, terraform_state: %{}}
    @invalid_attrs %{configuration: nil, terraform_state: nil}

    def service_fixture(attrs \\ %{}) do
      {:ok, service} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Generator.create_service()

      service
    end

    test "list_services/0 returns all services" do
      service = service_fixture()
      assert Generator.list_services() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = service_fixture()
      assert Generator.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      assert {:ok, %Service{} = service} = Generator.create_service(@valid_attrs)
      assert service.configuration == %{}
      assert service.terraform_state == %{}
    end

    test "create_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Generator.create_service(@invalid_attrs)
    end

    test "update_service/2 with valid data updates the service" do
      service = service_fixture()
      assert {:ok, service} = Generator.update_service(service, @update_attrs)
      assert %Service{} = service
      assert service.configuration == %{}
      assert service.terraform_state == %{}
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = service_fixture()
      assert {:error, %Ecto.Changeset{}} = Generator.update_service(service, @invalid_attrs)
      assert service == Generator.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service = service_fixture()
      assert {:ok, %Service{}} = Generator.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Generator.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service = service_fixture()
      assert %Ecto.Changeset{} = Generator.change_service(service)
    end
  end
end
