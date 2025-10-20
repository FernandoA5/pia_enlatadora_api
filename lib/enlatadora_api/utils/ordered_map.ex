defmodule EnlatadoraApi.Utils.OrderedMap do
  @moduledoc """
  Estructura que preserva el orden de las claves para serialización JSON.
  Solución genérica para cualquier stored procedure.
  """
  defstruct [:data, :keys]

  @doc """
  Crea un nuevo OrderedMap preservando el orden de las claves.
  """
  def from_pairs_list(pairs) when is_list(pairs) do
    keys = Enum.map(pairs, &elem(&1, 0))
    data = :maps.from_list(pairs)

    %__MODULE__{
      data: data,
      keys: keys
    }
  end

  @doc """
  Método especial para manejar resultados de stored procedures.
  Devuelve el primer elemento si es una lista, o el valor original si no lo es.
  """
  def normalize_sp_result([%__MODULE__{} = first | _]), do: first
  def normalize_sp_result(other), do: other

  @doc """
  Método para aplicar el normalizador al resultado de un stored procedure.
  Util para mantener la compatibilidad con endpoints existentes.
  """
  def handle_sp_result({:ok, result}), do: {:ok, normalize_sp_result(result)}
  def handle_sp_result(other), do: other
end

# Implementar el protocolo Jason para serializar en el orden correcto
defimpl Jason.Encoder, for: EnlatadoraApi.Utils.OrderedMap do
  def encode(%EnlatadoraApi.Utils.OrderedMap{data: data, keys: keys}, opts) do
    iodata =
      keys
      |> Enum.map(fn key ->
        value = Map.get(data, key)

        encoded_value =
          if is_binary(value) and not String.valid?(value) do
            # Normaliza solo binarios no UTF-8; el resto lo delega a Jason
            Jason.Encoder.encode("0x" <> Base.encode16(value, case: :lower), opts)
          else
            Jason.Encoder.encode(value, opts)
          end

        encoded_key = Jason.Encoder.encode(to_string(key), opts)
        [encoded_key, ?:, encoded_value]
      end)
      |> Enum.intersperse(?,)

    [?{, iodata, ?}]
  end
end
