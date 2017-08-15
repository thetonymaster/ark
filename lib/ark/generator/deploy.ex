defmodule Ark.Generator.Deploy do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ark.Generator.Deploy


  schema "deploys" do
    field :configuration, :map
    field :terraform_state, :map
    field :application_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Deploy{} = deploy, attrs) do
    deploy
    |> cast(attrs, [:configuration, :terraform_state])
    |> validate_required([:configuration, :terraform_state])
  end
end
