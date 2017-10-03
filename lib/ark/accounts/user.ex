defmodule Ark.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ark.Accounts.User


  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :todos, ArkWeb.Todo

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password_hash])
    |> validate_required([:email, :password_hash])
    |> validate_length(:password_hash, min: 6)
    |> put_password_hash()    
  end

  def registration_changeset(%User{} = user, params) do
  user
  |> changeset(params)
  |> cast(params, ~w(password), [])
  |> validate_length(:password, min: 3)
  |> put_password_hash()
  end

#DOUBTS IN THIS PART
#def registration_changeset(model, params) do
#  model
#  |> changeset(params)
#  |> cast(params, [:password])
#  |> validate_length(:password, min: 6)
#  |> put_password_hash()
#end
#


defp put_password_hash(changeset) do
  case changeset do
    %Ecto.Changeset{valid?: true, changes: %{password_hash: pass}} ->
      put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))

    _ ->
      changeset  
    end
  end
end
