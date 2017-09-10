defmodule Ark.Repo.Migrations.CreateCredentials do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add :details, :map

      timestamps()
    end

  end
end
