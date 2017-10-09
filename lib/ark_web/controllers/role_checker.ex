defmodule Ark.RoleChecker do
  alias Ark.Repo
  alias Ark.Accounts.Role

  def is_admin?(user) do
    (role = Repo.get(Role, user.role_id)) && role.admin
  end
end
