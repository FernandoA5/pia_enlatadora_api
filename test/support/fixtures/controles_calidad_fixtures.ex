defmodule EnlatadoraApi.ControlesCalidadFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EnlatadoraApi.ControlesCalidad` context.
  """

  @doc """
  Generate a control_calidad.
  """
  def control_calidad_fixture(attrs \\ %{}) do
    {:ok, control_calidad} =
      attrs
      |> Enum.into(%{
        activo: true,
        fecha_control: ~D[2025-10-25],
        observaciones: "some observaciones",
        resultado: "some resultado"
      })
      |> EnlatadoraApi.ControlesCalidad.create_control_calidad()

    control_calidad
  end
end
