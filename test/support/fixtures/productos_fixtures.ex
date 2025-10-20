defmodule EnlatadoraApi.ProductosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EnlatadoraApi.Productos` context.
  """

  @doc """
  Generate a producto.
  """
  def producto_fixture(attrs \\ %{}) do
    {:ok, producto} =
      attrs
      |> Enum.into(%{
        activo: true,
        descripcion: "some descripcion",
        nombre: "some nombre",
        stock_actual: "120.5",
        unidad_medida: "some unidad_medida"
      })
      |> EnlatadoraApi.Productos.create_producto()

    producto
  end
end
