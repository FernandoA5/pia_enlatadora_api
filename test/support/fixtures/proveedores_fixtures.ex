defmodule EnlatadoraApi.ProveedoresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EnlatadoraApi.Proveedores` context.
  """

  @doc """
  Generate a proveedor.
  """
  def proveedor_fixture(attrs \\ %{}) do
    {:ok, proveedor} =
      attrs
      |> Enum.into(%{
        activo: true,
        correo: "some correo",
        direccion: "some direccion",
        nombre: "some nombre",
        telefono: "some telefono"
      })
      |> EnlatadoraApi.Proveedores.create_proveedor()

    proveedor
  end
end
