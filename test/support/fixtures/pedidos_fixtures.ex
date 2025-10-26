defmodule EnlatadoraApi.PedidosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EnlatadoraApi.Pedidos` context.
  """

  @doc """
  Generate a pedido.
  """
  def pedido_fixture(attrs \\ %{}) do
    {:ok, pedido} =
      attrs
      |> Enum.into(%{
        activo: true,
        fecha_pedido: ~D[2025-10-25],
        total: "120.5"
      })
      |> EnlatadoraApi.Pedidos.create_pedido()

    pedido
  end
end
