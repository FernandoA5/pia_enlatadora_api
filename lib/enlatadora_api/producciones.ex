defmodule EnlatadoraApi.Producciones do
  @moduledoc """
  The Producciones context.
  """

  import Ecto.Query, warn: false
  alias EnlatadoraApi.Repo
  alias EnlatadoraApi.Utils
  alias EnlatadoraApi.ErrorHandler

  alias EnlatadoraApi.Producciones.Produccion

  @doc """
  Returns the list of producciones.

  ## Examples

      iex> list_producciones()
      [%Produccion{}, ...]

  """
  def list_producciones do
    Repo.all(Produccion)
  end

  @doc """
  Gets a single produccion.

  Raises `Ecto.NoResultsError` if the Produccion does not exist.

  ## Examples

      iex> get_produccion!(123)
      %Produccion{}

      iex> get_produccion!(456)
      ** (Ecto.NoResultsError)

  """
  def get_produccion!(id), do: Repo.get!(Produccion, id)

  @doc """
  Ejecuta el stored procedure `Produccion.obtener_producciones` para obtener las
  producciones con información extendida (incluyendo el nombre del producto).
  """
  def obtener_producciones do
    Utils.exec_sp_with_error_handling_ordered(
      "Produccion.obtener_producciones",
      %{},
      ErrorHandler
    )
  end

  @doc """
  Creates a produccion.

  ## Examples

      iex> create_produccion(%{field: value})
      {:ok, %Produccion{}}

      iex> create_produccion(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_produccion(attrs) do
    %Produccion{}
    |> Produccion.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a produccion.

  ## Examples

      iex> update_produccion(produccion, %{field: new_value})
      {:ok, %Produccion{}}

      iex> update_produccion(produccion, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_produccion(%Produccion{} = produccion, attrs) do
    produccion
    |> Produccion.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a produccion.

  ## Examples

      iex> delete_produccion(produccion)
      {:ok, %Produccion{}}

      iex> delete_produccion(produccion)
      {:error, %Ecto.Changeset{}}

  """
  def delete_produccion(%Produccion{} = produccion) do
    Repo.delete(produccion)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking produccion changes.

  ## Examples

      iex> change_produccion(produccion)
      %Ecto.Changeset{data: %Produccion{}}

  """
  def change_produccion(%Produccion{} = produccion, attrs \\ %{}) do
    Produccion.changeset(produccion, attrs)
  end
end
