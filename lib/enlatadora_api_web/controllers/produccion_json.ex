defmodule EnlatadoraApiWeb.ProduccionJSON do
  alias EnlatadoraApi.Producciones.Produccion
  alias EnlatadoraApi.Utils.OrderedMap

  @doc """
  Renders a list of producciones.
  """
  def index(%{producciones: producciones}) do
    %{data: for(produccion <- producciones, do: data(produccion))}
  end

  @doc """
  Renders a single produccion.
  """
  def show(%{produccion: produccion}) do
    case produccion do
      list when is_list(list) -> %{data: Enum.map(list, &data/1)}
      other -> %{data: data(other)}
    end
  end

  defp data(%Produccion{} = produccion) do
    %{
      id: produccion.id,
      fecha_produccion: produccion.fecha_produccion,
      cantidad_producida: produccion.cantidad_producida,
      estado: produccion.estado,
      activo: produccion.activo
    }
  end

  defp data(%OrderedMap{} = ordered), do: ordered
  defp data(%{} = map), do: map
  defp data(other), do: %{value: other}
end
