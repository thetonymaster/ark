defmodule Ark.Generator.Application do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ark.Generator.Application


  schema "applications" do
    field :description, :string
    field :logo, :string
    field :name, :string
    field :files, :string

    timestamps()
  end

  @doc false
  def changeset(%Application{} = application, attrs) do
    application
    |> cast(attrs, [:name, :logo, :description, :files])
    |> validate_required([:name, :logo, :description, :files])
  end
end
