defmodule EnlatadoraApi.Compras do
  @moduledoc """
  The Compras context.
  """

  import Ecto.Query, warn: false
  alias EnlatadoraApi.Repo
  alias EnlatadoraApi.Utils
  alias EnlatadoraApi.Utils.OrderedMap
  alias EnlatadoraApi.ErrorHandler

  alias EnlatadoraApi.Compras.CompraMateriaPrima

  @doc """
  Ejecuta el procedimiento almacenado `Compras.obtener_compras_materia_prima` y
  devuelve la lista de compras con el nombre del proveedor asociado.
  """
  def obtener_compras_materia_prima do
    "Compras.obtener_compras_materia_prima"
    |> Utils.exec_sp_with_error_handling_ordered(%{}, ErrorHandler)
  end

  @doc """
  Gets a single compra_materia_prima.

  Raises `Ecto.NoResultsError` if the Compra materia prima does not exist.

  ## Examples

      iex> get_compra_materia_prima!(123)
      %CompraMateriaPrima{}

      iex> get_compra_materia_prima!(456)
      ** (Ecto.NoResultsError)

  """
  def get_compra_materia_prima!(id), do: Repo.get!(CompraMateriaPrima, id)

  @doc """
  Creates a compra_materia_prima.

  ## Examples

      iex> create_compra_materia_prima(%{field: value})
      {:ok, %CompraMateriaPrima{}}

      iex> create_compra_materia_prima(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_compra_materia_prima(attrs) do
    %CompraMateriaPrima{}
    |> CompraMateriaPrima.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a compra_materia_prima.

  ## Examples

      iex> update_compra_materia_prima(compra_materia_prima, %{field: new_value})
      {:ok, %CompraMateriaPrima{}}

      iex> update_compra_materia_prima(compra_materia_prima, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_compra_materia_prima(%CompraMateriaPrima{} = compra_materia_prima, attrs) do
    compra_materia_prima
    |> CompraMateriaPrima.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a compra_materia_prima.

  ## Examples

      iex> delete_compra_materia_prima(compra_materia_prima)
      {:ok, %CompraMateriaPrima{}}

      iex> delete_compra_materia_prima(compra_materia_prima)
      {:error, %Ecto.Changeset{}}

  """
  def delete_compra_materia_prima(%CompraMateriaPrima{} = compra_materia_prima) do
    Repo.delete(compra_materia_prima)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking compra_materia_prima changes.

  ## Examples

      iex> change_compra_materia_prima(compra_materia_prima)
      %Ecto.Changeset{data: %CompraMateriaPrima{}}

  """
  def change_compra_materia_prima(%CompraMateriaPrima{} = compra_materia_prima, attrs \\ %{}) do
    CompraMateriaPrima.changeset(compra_materia_prima, attrs)
  end
end
