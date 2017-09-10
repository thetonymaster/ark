defmodule Ark.Generator.Service do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ark.Generator.Service


  schema "services" do
    field :configuration, :map
    field :terraform_state, :map
    field :application_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Service{} = service, attrs) do
    service
    |> cast(attrs, [:configuration, :terraform_state])
    |> validate_required([:configuration, :terraform_state])
  end
end
