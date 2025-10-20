defmodule EnlatadoraApi.ComprasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EnlatadoraApi.Compras` context.
  """

  @doc """
  Generate a compra_materia_prima.
  """
  def compra_materia_prima_fixture(attrs \\ %{}) do
    {:ok, compra_materia_prima} =
      attrs
      |> Enum.into(%{
        activo: true,
        fecha_compra: ~D[2025-10-19],
        total: "120.5"
      })
      |> EnlatadoraApi.Compras.create_compra_materia_prima()

    compra_materia_prima
  end
end
