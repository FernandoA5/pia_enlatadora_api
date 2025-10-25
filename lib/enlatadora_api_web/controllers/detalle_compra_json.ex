defmodule EnlatadoraApiWeb.DetalleCompraJSON do
  alias EnlatadoraApi.DetalleCompras.DetalleCompra

  @doc """
  Renders a list of detalle_compras.
  """
  def index(%{detalle_compras: detalle_compras}) do
    %{data: for(detalle_compra <- detalle_compras, do: data(detalle_compra))}
  end

  @doc """
  Renders a single detalle_compra.
  """
  def show(%{detalle_compra: detalle_compra}) do
    %{data: data(detalle_compra)}
  end

  defp data(%DetalleCompra{} = detalle_compra) do
    %{
      id: detalle_compra.id,
      cantidad: detalle_compra.cantidad,
      precio_unitario: detalle_compra.precio_unitario
    }
  end
end
