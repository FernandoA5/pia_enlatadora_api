defmodule EnlatadoraApiWeb.PedidoJSON do
  alias EnlatadoraApi.Pedidos.Pedido
  alias EnlatadoraApi.Utils.OrderedMap

  @doc """
  Renders a list of pedidos.
  """
  def index(%{pedidos: pedidos}) do
    %{data: for(pedido <- pedidos, do: data(pedido))}
  end

  @doc """
  Renders a single pedido.
  """
  def show(%{pedido: pedido}) do
    %{data: data(pedido)}
  end

  defp data(%Pedido{} = pedido) do
    %{
      id: pedido.id,
      fecha_pedido: pedido.fecha_pedido,
      total: pedido.total,
      id_cliente: pedido.id_cliente,
      activo: pedido.activo
    }
  end

  defp data(%OrderedMap{} = ordered), do: ordered
  defp data(%{} = map), do: map
  defp data(other), do: %{value: other}
end
