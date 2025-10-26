defmodule EnlatadoraApi.ProduccionesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EnlatadoraApi.Producciones` context.
  """

  @doc """
  Generate a produccion.
  """
  def produccion_fixture(attrs \\ %{}) do
    {:ok, produccion} =
      attrs
      |> Enum.into(%{
        activo: true,
        cantidad_producida: "120.5",
        estado: "some estado",
        fecha_produccion: ~D[2025-10-24]
      })
      |> EnlatadoraApi.Producciones.create_produccion()

    produccion
  end
end
