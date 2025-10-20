defmodule EnlatadoraApi.Utils.DynamicSpMapper do
  @moduledoc """
  Mapea automáticamente atributos a parámetros de stored procedures
  usando convenciones y permitiendo overrides específicos.
  """

  @doc """
  Mapea un mapa de atributos a parámetros de SP usando convenciones.

  ## Ejemplos

      iex> attrs = %{"nombre" => "Juan", "apellido" => "Pérez"}
      iex> DynamicSpMapper.map_to_sp_params(attrs, "[Empleado].[RegistrarEmpleado]")
      [{"@Nombre", "Juan"}, {"@Apellido", "Pérez"}]

      iex> attrs = %{"no_empleado" => "EMP001"}
      iex> overrides = %{"no_empleado" => "@NoEmpleado"}
      iex> DynamicSpMapper.map_to_sp_params(attrs, "[Empleado].[RegistrarEmpleado]", overrides)
      [{"@NoEmpleado", "EMP001"}]
  """
  def map_to_sp_params(attrs, _sp_name, overrides \\ %{}) do
    attrs
    |> Enum.map(fn {key, value} ->
      sp_param = get_sp_param_name(key, overrides)
      norm_value = normalize_value_for_sp(value)
      {sp_param, norm_value}
    end)
    |> Enum.reject(fn {_, value} -> is_nil(value) end)
  end

  # Normaliza valores para SP:
  # - true/false -> 1/0
  # - "true"/"false" (cualquier caso) -> 1/0
  # - "1"/"0" -> 1/0 (enteros)
  # - otros valores se dejan tal cual
  defp normalize_value_for_sp(value) when is_boolean(value), do: if(value, do: 1, else: 0)

  defp normalize_value_for_sp(value) when is_binary(value) do
    case String.downcase(String.trim(value)) do
      "true" -> 1
      "false" -> 0
      "1" -> 1
      "0" -> 0
      _other -> value
    end
  end

  defp normalize_value_for_sp(value), do: value

  defp get_sp_param_name(key, overrides) do
    # Primero verificar si hay override específico
    case Map.get(overrides, key) do
      nil ->
        # Aplicar convención: snake_case -> PascalCase con @
        "@#{Macro.camelize(key)}"
      override_name ->
        override_name
    end
  end
end
