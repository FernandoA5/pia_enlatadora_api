defmodule EnlatadoraApiWeb.ProveedorJSON do
  alias EnlatadoraApi.Proveedores.Proveedor

  @doc """
  Renders a list of proveedores.
  """
  def index(%{proveedores: proveedores}) do
    %{data: for(proveedor <- proveedores, do: data(proveedor))}
  end

  @doc """
  Renders a single proveedor.
  """
  def show(%{proveedor: proveedor}) do
    %{data: data(proveedor)}
  end

  defp data(%Proveedor{} = proveedor) do
    %{
      id: proveedor.id,
      nombre: proveedor.nombre,
      telefono: proveedor.telefono,
      direccion: proveedor.direccion,
      correo: proveedor.correo,
      activo: proveedor.activo
    }
  end
end
