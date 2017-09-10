defmodule Ark.Repo.Migrations.CreateService do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :configuration, :map
      add :terraform_state, :map
      add :application_id, references(:applications, on_delete: :nothing)

      timestamps()
    end

    create index(:services, [:application_id])
  end
end
