defmodule EnlatadoraApi.DetalleCompras do
  @moduledoc """
  The DetalleCompras context.
  """

  import Ecto.Query, warn: false
  alias EnlatadoraApi.Repo
  alias EnlatadoraApi.Utils
  alias EnlatadoraApi.ErrorHandler

  alias EnlatadoraApi.DetalleCompras.DetalleCompra

  @doc """
  Returns the list of detalle_compras.

  ## Examples

      iex> list_detalle_compras()
      [%DetalleCompra{}, ...]

  """
  def list_detalle_compras do
    Repo.all(DetalleCompra)
  end

  @doc """
  Gets a single detalle_compra.

  Raises `Ecto.NoResultsError` if the Detalle compra does not exist.

  ## Examples

      iex> get_detalle_compra!(123)
      %DetalleCompra{}

      iex> get_detalle_compra!(456)
      ** (Ecto.NoResultsError)

  """
  def get_detalle_compra!(id), do: Repo.get!(DetalleCompra, id)

  @doc """
  Creates a detalle_compra.

  ## Examples

      iex> create_detalle_compra(%{field: value})
      {:ok, %DetalleCompra{}}

      iex> create_detalle_compra(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_detalle_compra(attrs) do
    %DetalleCompra{}
    |> DetalleCompra.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a detalle_compra.

  ## Examples

      iex> update_detalle_compra(detalle_compra, %{field: new_value})
      {:ok, %DetalleCompra{}}

      iex> update_detalle_compra(detalle_compra, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_detalle_compra(%DetalleCompra{} = detalle_compra, attrs) do
    detalle_compra
    |> DetalleCompra.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a detalle_compra.

  ## Examples

      iex> delete_detalle_compra(detalle_compra)
      {:ok, %DetalleCompra{}}

      iex> delete_detalle_compra(detalle_compra)
      {:error, %Ecto.Changeset{}}

  """
  def delete_detalle_compra(%DetalleCompra{} = detalle_compra) do
    Repo.delete(detalle_compra)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking detalle_compra changes.

  ## Examples

      iex> change_detalle_compra(detalle_compra)
      %Ecto.Changeset{data: %DetalleCompra{}}

  """
  def change_detalle_compra(%DetalleCompra{} = detalle_compra, attrs \\ %{}) do
    DetalleCompra.changeset(detalle_compra, attrs)
  end

  def registrar_detalles_compra(attrs) when is_map(attrs) do
    Utils.exec_sp_with_tvps(
      "Compras.registrar_detalles_compra",
      attrs,
      [
        %{
          param: "@Detalles",
          type: "Compras.DetalleComprasItemsType",
          rows: Map.get(attrs, "detalles", [])
        }
      ],
      ErrorHandler
    )
  end

  def obtener_detalles_por_compra(attrs) when is_map(attrs) do
    Utils.exec_sp_with_error_handling_ordered(
      "Compras.obtener_detalles_compra_by_id_compra",
      attrs,
      ErrorHandler
    )
  end
end
