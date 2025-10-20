defmodule EnlatadoraApi.Proveedores do
  @moduledoc """
  The Proveedores context.
  """

  import Ecto.Query, warn: false
  alias EnlatadoraApi.Repo

  alias EnlatadoraApi.Proveedores.Proveedor

  @doc """
  Returns the list of proveedores.

  ## Examples

      iex> list_proveedores()
      [%Proveedor{}, ...]

  """
  def list_proveedores do
    Repo.all(Proveedor)
  end

  @doc """
  Gets a single proveedor.

  Raises `Ecto.NoResultsError` if the Proveedor does not exist.

  ## Examples

      iex> get_proveedor!(123)
      %Proveedor{}

      iex> get_proveedor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_proveedor!(id), do: Repo.get!(Proveedor, id)

  @doc """
  Creates a proveedor.

  ## Examples

      iex> create_proveedor(%{field: value})
      {:ok, %Proveedor{}}

      iex> create_proveedor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_proveedor(attrs) do
    %Proveedor{}
    |> Proveedor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a proveedor.

  ## Examples

      iex> update_proveedor(proveedor, %{field: new_value})
      {:ok, %Proveedor{}}

      iex> update_proveedor(proveedor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_proveedor(%Proveedor{} = proveedor, attrs) do
    proveedor
    |> Proveedor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a proveedor.

  ## Examples

      iex> delete_proveedor(proveedor)
      {:ok, %Proveedor{}}

      iex> delete_proveedor(proveedor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_proveedor(%Proveedor{} = proveedor) do
    Repo.delete(proveedor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking proveedor changes.

  ## Examples

      iex> change_proveedor(proveedor)
      %Ecto.Changeset{data: %Proveedor{}}

  """
  def change_proveedor(%Proveedor{} = proveedor, attrs \\ %{}) do
    Proveedor.changeset(proveedor, attrs)
  end
end
