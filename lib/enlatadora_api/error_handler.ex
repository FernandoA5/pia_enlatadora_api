defmodule EnlatadoraApi.ErrorHandler do
  @moduledoc """
  Manejo de errores provenientes de SQL Server para integrarlos con la capa web.
  """

  alias Ecto.Changeset
  alias EnlatadoraApi.Utils.OrderedMap

  @doc """
  Devuelve `{:error, %Ecto.Changeset{}}` para que `FallbackController` lo trate como 422.
  """
  def handle_db_error(error) do
    message = extract_message(error)

    changeset =
      %Changeset{data: %{}, valid?: false, changes: %{}, errors: []}
      |> Changeset.add_error(:base, message)

    {:error, changeset}
  end

  def handle_db_success(%OrderedMap{} = ordered, _attrs), do: ordered

  def handle_db_success(list, attrs) when is_list(list) do
    Enum.map(list, &handle_db_success(&1, attrs))
  end

  def handle_db_success(other, _attrs), do: other

  # Extrae el mensaje de texto directamente del error SQL Server
  defp extract_message(%{mssql: %{msg_text: msg}}) when is_binary(msg), do: msg
  defp extract_message(%{message: msg}) when is_binary(msg), do: msg
  defp extract_message(error), do: inspect(error)
end
