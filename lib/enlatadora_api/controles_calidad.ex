defmodule EnlatadoraApi.ControlesCalidad do
  @moduledoc """
  The ControlesCalidad context.
  """

  import Ecto.Query, warn: false
  alias EnlatadoraApi.Repo
  alias EnlatadoraApi.Utils
  alias EnlatadoraApi.ErrorHandler

  alias EnlatadoraApi.ControlesCalidad.ControlCalidad

  @doc """
  Returns the list of controles_calidad.

  ## Examples

      iex> list_controles_calidad()
      [%ControlCalidad{}, ...]

  """
  def list_controles_calidad do
    Repo.all(ControlCalidad)
  end

  @doc """
  Gets a single control_calidad.

  Raises `Ecto.NoResultsError` if the Control calidad does not exist.

  ## Examples

      iex> get_control_calidad!(123)
      %ControlCalidad{}

      iex> get_control_calidad!(456)
      ** (Ecto.NoResultsError)

  """
  def get_control_calidad!(id), do: Repo.get!(ControlCalidad, id)

  @doc """
  Creates a control_calidad.

  ## Examples

      iex> create_control_calidad(%{field: value})
      {:ok, %ControlCalidad{}}

      iex> create_control_calidad(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_control_calidad(attrs) do
    %ControlCalidad{}
    |> ControlCalidad.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a control_calidad.

  ## Examples

      iex> update_control_calidad(control_calidad, %{field: new_value})
      {:ok, %ControlCalidad{}}

      iex> update_control_calidad(control_calidad, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_control_calidad(%ControlCalidad{} = control_calidad, attrs) do
    control_calidad
    |> ControlCalidad.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a control_calidad.

  ## Examples

      iex> delete_control_calidad(control_calidad)
      {:ok, %ControlCalidad{}}

      iex> delete_control_calidad(control_calidad)
      {:error, %Ecto.Changeset{}}

  """
  def delete_control_calidad(%ControlCalidad{} = control_calidad) do
    Repo.delete(control_calidad)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking control_calidad changes.

  ## Examples

      iex> change_control_calidad(control_calidad)
      %Ecto.Changeset{data: %ControlCalidad{}}

  """
  def change_control_calidad(%ControlCalidad{} = control_calidad, attrs \\ %{}) do
    ControlCalidad.changeset(control_calidad, attrs)
  end

  @doc """
  Obtiene el control de calidad más reciente asociado a una producción.
  """
  def obtener_control_calidad_por_produccion(attrs) when is_map(attrs) do
    Utils.exec_sp_with_error_handling_ordered(
      "Produccion.obtener_control_calidad_por_produccion",
      attrs,
      ErrorHandler
    )
  end
end
