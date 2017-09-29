defmodule Ark.Accounts.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ark.Accounts.Todo


  schema "todos" do
    field :completed, :boolean, default: false
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Todo{} = todo, attrs) do
    todo
    |> cast(attrs, [:title, :completed])
    |> validate_required([:title, :completed])
  end
end
