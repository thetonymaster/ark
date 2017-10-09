defmodule Ark.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ark.Accounts.Role


  schema "roles" do
    field :admin, :boolean, default: false
    field :name, :string
    has_many :users, Ark.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Role{} = role, attrs) do
    role
    |> cast(attrs, [:name, :admin])
    |> validate_required([:name, :admin])
  end
end
