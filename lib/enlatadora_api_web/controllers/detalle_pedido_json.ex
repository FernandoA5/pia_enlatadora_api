defmodule EnlatadoraApiWeb.DetallePedidoJSON do
  alias EnlatadoraApi.DetallesPedido.DetallePedido

  @doc """
  Renders a list of detalles_pedido.
  """
  def index(%{detalles_pedido: detalles_pedido}) do
    %{data: for(detalle_pedido <- detalles_pedido, do: data(detalle_pedido))}
  end

  @doc """
  Renders a single detalle_pedido.
  """
  def show(%{detalle_pedido: detalle_pedido}) do
    %{data: data(detalle_pedido)}
  end

  defp data(%DetallePedido{} = detalle_pedido) do
    %{
      id: detalle_pedido.id,
      cantidad: detalle_pedido.cantidad,
      precio_unitario: detalle_pedido.precio_unitario,
      activo: detalle_pedido.activo
    }
  end
end
