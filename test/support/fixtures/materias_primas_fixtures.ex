defmodule EnlatadoraApi.MateriasPrimasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EnlatadoraApi.MateriasPrimas` context.
  """

  @doc """
  Generate a materia_prima.
  """
  def materia_prima_fixture(attrs \\ %{}) do
    {:ok, materia_prima} =
      attrs
      |> Enum.into(%{
        descripcion: "some descripcion",
        nombre: "some nombre",
        stock_actual: "120.5",
        stock_minimo: "120.5",
        unidad_medida: "some unidad_medida"
      })
      |> EnlatadoraApi.MateriasPrimas.create_materia_prima()

    materia_prima
  end
end
