defmodule EnlatadoraApiWeb.ClienteJSON do
  alias EnlatadoraApi.Clientes.Cliente

  @doc """
  Renders a list of clientes.
  """
  def index(%{clientes: clientes}) do
    %{data: for(cliente <- clientes, do: data(cliente))}
  end

  @doc """
  Renders a single cliente.
  """
  def show(%{cliente: cliente}) do
    %{data: data(cliente)}
  end

  defp data(%Cliente{} = cliente) do
    %{
      id: cliente.id,
      nombre: cliente.nombre,
      telefono: cliente.telefono,
      direccion: cliente.direccion,
      correo: cliente.correo,
      activo: cliente.activo
    }
  end
end
