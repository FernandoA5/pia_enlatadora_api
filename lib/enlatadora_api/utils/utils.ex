defmodule EnlatadoraApi.Utils do
  @moduledoc """
  Utilidades para el manejo de stored procedures y mapeo de datos.
  """

  alias EnlatadoraApi.Repo
  alias EnlatadoraApi.Utils.DynamicSpMapper
  alias EnlatadoraApi.Utils.OrderedMap


  @doc """
  Versión que preserva el orden de columnas para serialización JSON.
  """
  def parse_sp_result_with_order(rows, columns) do
    rows
    |> Enum.map(fn item ->
      Enum.zip(columns, item)
      |> OrderedMap.from_pairs_list()
    end)
  end

  @doc """
  Ejecuta un stored procedure con manejo de errores y devuelve los resultados
  como mapas ordenados (preserva el orden de columnas), útil para respuestas JSON.

  Si el procedimiento devuelve una lista con un solo elemento, extrae automáticamente
  ese elemento para evitar problemas con los controladores que esperan un objeto único.
  """
  def exec_sp_with_error_handling_ordered(sp_name, attrs, error_handler) do
    try do
      params = DynamicSpMapper.map_to_sp_params(attrs, sp_name)
      # Inline de exec_sp/2
      {assigns, param_values, _i} =
        Enum.reduce(params, {[], [], 1}, fn {name, val}, {as, ps, i} ->
          { [" #{name}=@#{i}" | as], [val | ps], i + 1 }
        end)

      sql = "EXEC #{sp_name}" <> Enum.join(Enum.reverse(assigns), ",")
      param_values = Enum.reverse(param_values)
      %{rows: rows, columns: columns} = Repo.query!(sql, param_values)

      # Algunos SP pueden no retornar resultset (rows/columns = nil).
      # Normalizamos a lista vacía para mantener consistencia JSON.
      rows = rows || []
      columns = columns || []

      list = parse_sp_result_with_order(rows, columns)

      # Normalizar resultado para procedimientos que devuelven un solo registro
      # Si hay exactamente un elemento en la lista, lo extraemos
      result = case list do
        [single_item] when length(list) == 1 -> single_item
        other -> other
      end

      result = maybe_handle_success(error_handler, result, attrs)

      {:ok, result}
    rescue
      e -> error_handler.handle_db_error(e)
    end
  end

  defp maybe_handle_success(handler, result, attrs) do
    if function_exported?(handler, :handle_db_success, 2) do
      handler.handle_db_success(result, attrs)
    else
      result
    end
  end

  @doc """
  Ejecuta un Stored Procedure y devuelve el resultado crudo de `Repo.query/2`.

  No altera el orden de columnas ni decodifica valores; útil cuando el SP
  devuelve estructuras personalizadas (por ejemplo columnas con JSON).
  """
  def exec_sp_raw(sp_name, attrs, error_handler)
      when is_binary(sp_name) and is_map(attrs) do
    try do
      params = DynamicSpMapper.map_to_sp_params(attrs, sp_name)

      {assigns, param_values, _i} =
        Enum.reduce(params, {[], [], 1}, fn {name, val}, {as, ps, i} ->
          { [" #{name}=@#{i}" | as], [val | ps], i + 1 }
        end)

      sql =
        "SET NOCOUNT ON;\nEXEC #{sp_name}" <>
          Enum.join(Enum.reverse(assigns), ",")

      case Repo.query(sql, Enum.reverse(param_values)) do
        {:ok, result} -> {:ok, result}
        {:error, error} -> error_handler.handle_db_error(error)
      end
    rescue
      e -> error_handler.handle_db_error(e)
    end
  end

  @doc """
  Ejecuta un Stored Procedure con parámetros escalares y una o más TVPs de forma genérica.

  - `sp_name`: nombre completo del SP, e.g. "[Produccion].[RegistrarConversion]".
  - `attrs`: mapa de parámetros escalares; se mapean con DynamicSpMapper (snake_case -> @PascalCase).
  - `tvps`: lista de TVPs con campos: `:param` (nombre del parámetro del SP, ej. "@Productos"),
            `:type` (tipo tabla, ej. "[dbo].[ConversionProdcuto]"),
            `:columns` (lista de nombres de columnas) y `:rows` (lista de mapas).

  Devuelve {:ok, result} preservando el orden de columnas si hay resultset. Si no hay, {:ok, []}.
  """
  def exec_sp_with_tvps(sp_name, attrs, tvps, error_handler)
      when is_binary(sp_name) and is_map(attrs) and is_list(tvps) do
    try do
      # Mapear parámetros escalares (ignorando keys que colisionen con TVP params)
      tvp_param_names = Enum.map(tvps, &(&1[:param]))
      scalar_attrs =
        Enum.reject(attrs, fn {k, _v} ->
          param_name = "@" <> Macro.camelize(to_string(k))
          Enum.member?(tvp_param_names, param_name)
        end)
        |> Map.new()

      params = DynamicSpMapper.map_to_sp_params(scalar_attrs, sp_name)

      {assigns, param_values, _i} =
        Enum.reduce(params, {[], [], 1}, fn {name, val}, {as, ps, i} ->
          { [" #{name}=@#{i}" | as], [val | ps], i + 1 }
        end)

      exec_assigns = Enum.join(Enum.reverse(assigns), ",")

      # Declaración e inserción para cada TVP
      tvp_blocks =
        Enum.map(tvps, fn %{param: param, type: type} = tvp ->
          rows = Map.get(tvp, :rows, [])
          columns =
            case Map.get(tvp, :columns) do
              nil -> derive_tvp_columns_from_rows(rows)
              [] -> derive_tvp_columns_from_rows(rows)
              cols -> Enum.map(cols, &to_string/1)
            end
          var = param # Usamos el mismo nombre para la variable local
          declare = "DECLARE #{var} #{type};"

          insert_rows =
            rows
            |> List.wrap()
            |> Enum.map(fn row ->
              values =
                Enum.map(columns, fn col ->
                  val = Map.get(row, col) || Map.get(row, to_string(col)) || Map.get(row, String.to_atom(col))
                  format_tvp_value(val)
                end)

              "INSERT INTO #{var} (#{Enum.join(columns, ", ")}) VALUES(#{Enum.join(values, ", ")});"
            end)
            |> Enum.join("\n")

          declare <> "\n" <> insert_rows
        end)
        |> Enum.join("\n\n")

      # Agregar los parámetros TVP al EXEC como referencias a las variables locales
      tvp_exec_assigns =
        tvps
        |> Enum.map(fn %{param: param} -> " #{param}=#{param}" end)
        |> Enum.join(",")

      sep = if exec_assigns == "", do: " ", else: ","
      exec_sql =
        "EXEC #{sp_name}" <> exec_assigns <> (if tvp_exec_assigns == "", do: "", else: sep <> tvp_exec_assigns)

      final_sql =
        (if tvp_blocks == "", do: exec_sql, else: tvp_blocks <> "\n" <> exec_sql)

      %{rows: rows, columns: columns} = Repo.query!(final_sql, Enum.reverse(param_values))

      rows = rows || []
      columns = columns || []
      list = parse_sp_result_with_order(rows, columns)

      result = case list do
        [single_item] when length(list) == 1 -> single_item
        other -> other
      end

      {:ok, result}
    rescue
      e -> error_handler.handle_db_error(e)
    end
  end

  # Formatea valores para inserción en TVP: cadenas con comillas escapadas, nil como NULL
  defp format_tvp_value(nil), do: "NULL"
  defp format_tvp_value(val) when is_binary(val), do: "'" <> String.replace(val, "'", "''") <> "'"
  defp format_tvp_value(val), do: to_string(val)

  # Deriva nombres de columnas para un TVP a partir de las llaves del primer row
  defp derive_tvp_columns_from_rows(rows) do
    case List.wrap(rows) do
      [first | _] -> first |> Map.keys() |> Enum.map(&to_string/1)
      _ -> []
    end
  end
end
