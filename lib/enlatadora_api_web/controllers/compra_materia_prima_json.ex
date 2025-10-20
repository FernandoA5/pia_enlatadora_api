defmodule EnlatadoraApiWeb.CompraMateriaPrimaJSON do
  alias EnlatadoraApi.Compras.CompraMateriaPrima

  @doc """
  Renders a list of compras_materia_prima.
  """
  def index(%{compras_materia_prima: compras_materia_prima}) do
    %{data: for(compra_materia_prima <- compras_materia_prima, do: data(compra_materia_prima))}
  end

  @doc """
  Renders a single compra_materia_prima.
  """
  def show(%{compra_materia_prima: compra_materia_prima}) do
    %{data: data(compra_materia_prima)}
  end

  defp data(%CompraMateriaPrima{} = compra_materia_prima) do
    %{
      id: compra_materia_prima.id,
      fecha_compra: compra_materia_prima.fecha_compra,
      total: compra_materia_prima.total,
      activo: compra_materia_prima.activo
    }
  end
end
