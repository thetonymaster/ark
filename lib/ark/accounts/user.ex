defmodule Ark.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ark.Accounts.User


  schema "users" do
    field :email, :string
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password_hash])
    |> validate_required([:email, :password_hash])
  end

def registration_changeset(model, params) do
  model
  |> changeset(params)
  |> cast(params, ~w(password), [])
  |> validate_length(:password, min: 6)
  |> put_password_hash()
end

def put_password_hash(changeset) do
  case changeset do
    %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
      put_change(changeset, :password_hash,   
                 Comeonin.Bcrypt.hashpwsalt(pass))

    _ ->
      changeset  
  end
end
end
