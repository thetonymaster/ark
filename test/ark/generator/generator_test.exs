defmodule Ark.GeneratorTest do
  use Ark.DataCase

  alias Ark.Generator

  describe "applications" do
    alias Ark.Generator.Application

    @valid_attrs %{description: "some description", logo: "some logo", name: "some name", template: "some template"}
    @update_attrs %{description: "some updated description", logo: "some updated logo", name: "some updated name", template: "some updated template"}
    @invalid_attrs %{description: nil, logo: nil, name: nil, template: nil}

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
      assert application.template == "some template"
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
      assert application.template == "some updated template"
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

  describe "deploys" do
    alias Ark.Generator.Deploy

    @valid_attrs %{configuration: %{}, terraform_state: %{}}
    @update_attrs %{configuration: %{}, terraform_state: %{}}
    @invalid_attrs %{configuration: nil, terraform_state: nil}

    def deploy_fixture(attrs \\ %{}) do
      {:ok, deploy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Generator.create_deploy()

      deploy
    end

    test "list_deploys/0 returns all deploys" do
      deploy = deploy_fixture()
      assert Generator.list_deploys() == [deploy]
    end

    test "get_deploy!/1 returns the deploy with given id" do
      deploy = deploy_fixture()
      assert Generator.get_deploy!(deploy.id) == deploy
    end

    test "create_deploy/1 with valid data creates a deploy" do
      assert {:ok, %Deploy{} = deploy} = Generator.create_deploy(@valid_attrs)
      assert deploy.configuration == %{}
      assert deploy.terraform_state == %{}
    end

    test "create_deploy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Generator.create_deploy(@invalid_attrs)
    end

    test "update_deploy/2 with valid data updates the deploy" do
      deploy = deploy_fixture()
      assert {:ok, deploy} = Generator.update_deploy(deploy, @update_attrs)
      assert %Deploy{} = deploy
      assert deploy.configuration == %{}
      assert deploy.terraform_state == %{}
    end

    test "update_deploy/2 with invalid data returns error changeset" do
      deploy = deploy_fixture()
      assert {:error, %Ecto.Changeset{}} = Generator.update_deploy(deploy, @invalid_attrs)
      assert deploy == Generator.get_deploy!(deploy.id)
    end

    test "delete_deploy/1 deletes the deploy" do
      deploy = deploy_fixture()
      assert {:ok, %Deploy{}} = Generator.delete_deploy(deploy)
      assert_raise Ecto.NoResultsError, fn -> Generator.get_deploy!(deploy.id) end
    end

    test "change_deploy/1 returns a deploy changeset" do
      deploy = deploy_fixture()
      assert %Ecto.Changeset{} = Generator.change_deploy(deploy)
    end
  end
end
