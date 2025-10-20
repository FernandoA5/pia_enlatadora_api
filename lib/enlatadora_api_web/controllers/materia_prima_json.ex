defmodule EnlatadoraApiWeb.MateriaPrimaJSON do
  alias EnlatadoraApi.MateriasPrimas.MateriaPrima

  @doc """
  Renders a list of materias_primas.
  """
  def index(%{materias_primas: materias_primas}) do
    %{data: for(materia_prima <- materias_primas, do: data(materia_prima))}
  end

  @doc """
  Renders a single materia_prima.
  """
  def show(%{materia_prima: materia_prima}) do
    %{data: data(materia_prima)}
  end

  defp data(%MateriaPrima{} = materia_prima) do
    %{
      id: materia_prima.id,
      nombre: materia_prima.nombre,
      descripcion: materia_prima.descripcion,
      unidad_medida: materia_prima.unidad_medida,
      stock_actual: materia_prima.stock_actual,
      stock_minimo: materia_prima.stock_minimo
    }
  end
end
