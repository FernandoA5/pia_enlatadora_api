defmodule EnlatadoraApi.ClientesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EnlatadoraApi.Clientes` context.
  """

  @doc """
  Generate a cliente.
  """
  def cliente_fixture(attrs \\ %{}) do
    {:ok, cliente} =
      attrs
      |> Enum.into(%{
        activo: true,
        correo: "some correo",
        direccion: "some direccion",
        nombre: "some nombre",
        telefono: "some telefono"
      })
      |> EnlatadoraApi.Clientes.create_cliente()

    cliente
  end
end
