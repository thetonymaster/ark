defmodule Ark.Configuration.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ark.Configuration.Credential


  schema "credentials" do
    field :details, :map

    timestamps()
  end

  @doc false
  def changeset(%Credential{} = credential, attrs) do
    credential
    |> cast(attrs, [:details])
    |> validate_required([:details])
  end
end
