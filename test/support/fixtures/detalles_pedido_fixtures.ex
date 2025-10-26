defmodule EnlatadoraApi.DetallesPedidoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EnlatadoraApi.DetallesPedido` context.
  """

  @doc """
  Generate a detalle_pedido.
  """
  def detalle_pedido_fixture(attrs \\ %{}) do
    {:ok, detalle_pedido} =
      attrs
      |> Enum.into(%{
        activo: true,
        cantidad: "120.5",
        precio_unitario: "120.5"
      })
      |> EnlatadoraApi.DetallesPedido.create_detalle_pedido()

    detalle_pedido
  end
end
