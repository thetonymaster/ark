defmodule Ark.Generator do
  @moduledoc """
  The Generator context.
  """

  import Ecto.Query, warn: false
  alias Ark.Repo

  alias Ark.Generator.Application

  @doc """
  Returns the list of applications.

  ## Examples

      iex> list_applications()
      [%Application{}, ...]

  """
  def list_applications do
    Repo.all(Application)
  end

  @doc """
  Gets a single application.

  Raises `Ecto.NoResultsError` if the Application does not exist.

  ## Examples

      iex> get_application!(123)
      %Application{}

      iex> get_application!(456)
      ** (Ecto.NoResultsError)

  """
  def get_application!(id), do: Repo.get!(Application, id)

  @doc """
  Creates a application.

  ## Examples

      iex> create_application(%{field: value})
      {:ok, %Application{}}

      iex> create_application(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_application(attrs \\ %{}) do
    %Application{}
    |> Application.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a application.

  ## Examples

      iex> update_application(application, %{field: new_value})
      {:ok, %Application{}}

      iex> update_application(application, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_application(%Application{} = application, attrs) do
    application
    |> Application.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Application.

  ## Examples

      iex> delete_application(application)
      {:ok, %Application{}}

      iex> delete_application(application)
      {:error, %Ecto.Changeset{}}

  """
  def delete_application(%Application{} = application) do
    Repo.delete(application)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking application changes.

  ## Examples

      iex> change_application(application)
      %Ecto.Changeset{source: %Application{}}

  """
  def change_application(%Application{} = application) do
    Application.changeset(application, %{})
  end

  alias Ark.Generator.Deploy

  @doc """
  Returns the list of deploys.

  ## Examples

      iex> list_deploys()
      [%Deploy{}, ...]

  """
  def list_deploys do
    Repo.all(Deploy)
  end

  @doc """
  Gets a single deploy.

  Raises `Ecto.NoResultsError` if the Deploy does not exist.

  ## Examples

      iex> get_deploy!(123)
      %Deploy{}

      iex> get_deploy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deploy!(id), do: Repo.get!(Deploy, id)

  @doc """
  Creates a deploy.

  ## Examples

      iex> create_deploy(%{field: value})
      {:ok, %Deploy{}}

      iex> create_deploy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deploy(attrs \\ %{}) do
    %Deploy{}
    |> Deploy.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a deploy.

  ## Examples

      iex> update_deploy(deploy, %{field: new_value})
      {:ok, %Deploy{}}

      iex> update_deploy(deploy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deploy(%Deploy{} = deploy, attrs) do
    deploy
    |> Deploy.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Deploy.

  ## Examples

      iex> delete_deploy(deploy)
      {:ok, %Deploy{}}

      iex> delete_deploy(deploy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deploy(%Deploy{} = deploy) do
    Repo.delete(deploy)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deploy changes.

  ## Examples

      iex> change_deploy(deploy)
      %Ecto.Changeset{source: %Deploy{}}

  """
  def change_deploy(%Deploy{} = deploy) do
    Deploy.changeset(deploy, %{})
  end
end
