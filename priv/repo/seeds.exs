# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ark.Repo.insert!(%Ark.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Ark.Repo
alias Ark.Accounts.Role
alias Ark.Accounts.User

role = %Role{}
  |> Role.changeset(%{name: "Admin Role", admin: true})
  |> Ark.Repo.insert!

admin = %User{}
  |> User.changeset(%{username: "admin", email: "admin@test.com", password_hash: "123123", role_id: role.id})
  |> Ark.Repo.insert!
