defmodule Ark.ConfigurationTest do
  use Ark.DataCase

  alias Ark.Configuration

  describe "credentials" do
    alias Ark.Configuration.Credential

    @valid_attrs %{details: %{}}
    @update_attrs %{details: %{}}
    @invalid_attrs %{details: nil}

    def credential_fixture(attrs \\ %{}) do
      {:ok, credential} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Configuration.create_credential()

      credential
    end

    test "list_credentials/0 returns all credentials" do
      credential = credential_fixture()
      assert Configuration.list_credentials() == [credential]
    end

    test "get_credential!/1 returns the credential with given id" do
      credential = credential_fixture()
      assert Configuration.get_credential!(credential.id) == credential
    end

    test "create_credential/1 with valid data creates a credential" do
      assert {:ok, %Credential{} = credential} = Configuration.create_credential(@valid_attrs)
      assert credential.details == %{}
    end

    test "create_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Configuration.create_credential(@invalid_attrs)
    end

    test "update_credential/2 with valid data updates the credential" do
      credential = credential_fixture()
      assert {:ok, credential} = Configuration.update_credential(credential, @update_attrs)
      assert %Credential{} = credential
      assert credential.details == %{}
    end

    test "update_credential/2 with invalid data returns error changeset" do
      credential = credential_fixture()
      assert {:error, %Ecto.Changeset{}} = Configuration.update_credential(credential, @invalid_attrs)
      assert credential == Configuration.get_credential!(credential.id)
    end

    test "delete_credential/1 deletes the credential" do
      credential = credential_fixture()
      assert {:ok, %Credential{}} = Configuration.delete_credential(credential)
      assert_raise Ecto.NoResultsError, fn -> Configuration.get_credential!(credential.id) end
    end

    test "change_credential/1 returns a credential changeset" do
      credential = credential_fixture()
      assert %Ecto.Changeset{} = Configuration.change_credential(credential)
    end
  end
end
