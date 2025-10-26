defmodule EnlatadoraApiWeb.ControlCalidadJSON do
  alias EnlatadoraApi.ControlesCalidad.ControlCalidad
  alias EnlatadoraApi.Utils.OrderedMap

  @doc """
  Renders a list of controles_calidad.
  """
  def index(%{controles_calidad: controles_calidad}) do
    %{data: for(control_calidad <- controles_calidad, do: data(control_calidad))}
  end

  @doc """
  Renders a single control_calidad.
  """
  def show(%{control_calidad: control_calidad}) do
    case control_calidad do
      list when is_list(list) -> %{data: Enum.map(list, &data/1)}
      other -> %{data: data(other)}
    end
  end

  defp data(%ControlCalidad{} = control_calidad) do
    %{
      id: control_calidad.id,
      fecha_control: control_calidad.fecha_control,
      resultado: control_calidad.resultado,
      observaciones: control_calidad.observaciones,
      activo: control_calidad.activo,
      id_produccion: control_calidad.id_produccion
    }
  end

  defp data(%OrderedMap{} = ordered), do: ordered
  defp data(%{} = map), do: map
  defp data(other), do: %{value: other}
end
