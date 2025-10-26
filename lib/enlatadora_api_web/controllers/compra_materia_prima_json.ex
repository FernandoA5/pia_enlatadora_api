defmodule EnlatadoraApiWeb.CompraMateriaPrimaJSON do
  alias EnlatadoraApi.Compras.CompraMateriaPrima
  alias EnlatadoraApi.Utils.OrderedMap

  @doc """
  Renders a list of compras_materia_prima.
  """
  def index(%{compras_materia_prima: compras_materia_prima}) do
    %{data: Enum.map(compras_materia_prima, &data/1)}
  end

  @doc """
  Renders a single compra_materia_prima or the result of a stored procedure.
  """
  def show(%{compra_materia_prima: compra_materia_prima}) do
    case compra_materia_prima do
      list when is_list(list) -> %{data: Enum.map(list, &data/1)}
      other -> %{data: data(other)}
    end
  end

  defp data(%CompraMateriaPrima{} = compra_materia_prima) do
    %{
      id: compra_materia_prima.id,
      fecha_compra: compra_materia_prima.fecha_compra,
      id_proveedor: compra_materia_prima.id_proveedor,
      total: compra_materia_prima.total,
      activo: compra_materia_prima.activo
    }
  end

  defp data(%OrderedMap{} = ordered), do: ordered
  defp data(%{} = map), do: map
  defp data(other), do: %{value: other}
end
