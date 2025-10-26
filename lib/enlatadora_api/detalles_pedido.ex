defmodule EnlatadoraApi.DetallesPedido do
  @moduledoc """
  The DetallesPedido context.
  """

  import Ecto.Query, warn: false
  alias EnlatadoraApi.Repo
  alias EnlatadoraApi.Utils
  alias EnlatadoraApi.ErrorHandler

  alias EnlatadoraApi.DetallesPedido.DetallePedido

  @doc """
  Returns the list of detalles_pedido.

  ## Examples

      iex> list_detalles_pedido()
      [%DetallePedido{}, ...]

  """
  def list_detalles_pedido do
    Repo.all(DetallePedido)
  end

  @doc """
  Gets a single detalle_pedido.

  Raises `Ecto.NoResultsError` if the Detalle pedido does not exist.

  ## Examples

      iex> get_detalle_pedido!(123)
      %DetallePedido{}

      iex> get_detalle_pedido!(456)
      ** (Ecto.NoResultsError)

  """
  def get_detalle_pedido!(id), do: Repo.get!(DetallePedido, id)

  @doc """
  Creates a detalle_pedido.

  ## Examples

      iex> create_detalle_pedido(%{field: value})
      {:ok, %DetallePedido{}}

      iex> create_detalle_pedido(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_detalle_pedido(attrs) do
    %DetallePedido{}
    |> DetallePedido.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a detalle_pedido.

  ## Examples

      iex> update_detalle_pedido(detalle_pedido, %{field: new_value})
      {:ok, %DetallePedido{}}

      iex> update_detalle_pedido(detalle_pedido, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_detalle_pedido(%DetallePedido{} = detalle_pedido, attrs) do
    detalle_pedido
    |> DetallePedido.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a detalle_pedido.

  ## Examples

      iex> delete_detalle_pedido(detalle_pedido)
      {:ok, %DetallePedido{}}

      iex> delete_detalle_pedido(detalle_pedido)
      {:error, %Ecto.Changeset{}}

  """
  def delete_detalle_pedido(%DetallePedido{} = detalle_pedido) do
    Repo.delete(detalle_pedido)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking detalle_pedido changes.

  ## Examples

      iex> change_detalle_pedido(detalle_pedido)
      %Ecto.Changeset{data: %DetallePedido{}}

  """
  def change_detalle_pedido(%DetallePedido{} = detalle_pedido, attrs \\ %{}) do
    DetallePedido.changeset(detalle_pedido, attrs)
  end

  @doc """
  Ejecuta el procedimiento almacenado `Pedido.registrar_detalles_pedido` para
  insertar múltiples detalles de pedido en una sola transacción.
  """
  def registrar_detalles_pedido(attrs) when is_map(attrs) do
    Utils.exec_sp_with_tvps(
      "Pedido.registrar_detalles_pedido",
      attrs,
      [
        %{
          param: "@Detalles",
          type: "Pedido.DetallesPedidoItemsType",
          rows: Map.get(attrs, "detalles", [])
        }
      ],
      ErrorHandler
    )
  end

  @doc """
  Ejecuta el procedimiento almacenado `Pedido.obtener_detalles_pedido_by_id_pedido` y
  devuelve la lista de detalles de pedido con el nombre del producto asociado.
  """
  def obtener_detalles_por_pedido(attrs) when is_map(attrs) do
    Utils.exec_sp_with_error_handling_ordered(
      "Pedido.obtener_detalles_pedido_by_id_pedido",
      attrs,
      ErrorHandler
    )
  end
end
