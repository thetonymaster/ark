defmodule Ark.Repo.Migrations.CreateDeploys do
  use Ecto.Migration

  def change do
    create table(:deploys) do
      add :configuration, :map
      add :terraform_state, :map
      add :application_id, references(:applications, on_delete: :nothing)

      timestamps()
    end

    create index(:deploys, [:application_id])
  end
end
