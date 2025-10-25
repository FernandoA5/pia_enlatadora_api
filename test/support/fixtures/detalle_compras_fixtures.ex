defmodule EnlatadoraApi.DetalleComprasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EnlatadoraApi.DetalleCompras` context.
  """

  @doc """
  Generate a detalle_compra.
  """
  def detalle_compra_fixture(attrs \\ %{}) do
    {:ok, detalle_compra} =
      attrs
      |> Enum.into(%{
        cantidad: "120.5",
        precio_unitario: "120.5"
      })
      |> EnlatadoraApi.DetalleCompras.create_detalle_compra()

    detalle_compra
  end
end
