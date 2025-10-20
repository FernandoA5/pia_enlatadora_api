defmodule EnlatadoraApi.MateriasPrimas do
  @moduledoc """
  The MateriasPrimas context.
  """

  import Ecto.Query, warn: false
  alias EnlatadoraApi.Repo

  alias EnlatadoraApi.MateriasPrimas.MateriaPrima

  @doc """
  Returns the list of materias_primas.

  ## Examples

      iex> list_materias_primas()
      [%MateriaPrima{}, ...]

  """
  def list_materias_primas do
    from(m in MateriaPrima, where: m.activo == true)
    |> Repo.all()
  end

  @doc """
  Gets a single materia_prima.

  Raises `Ecto.NoResultsError` if the Materia prima does not exist.

  ## Examples

      iex> get_materia_prima!(123)
      %MateriaPrima{}

      iex> get_materia_prima!(456)
      ** (Ecto.NoResultsError)

  """
  def get_materia_prima!(id), do: Repo.get!(MateriaPrima, id)

  @doc """
  Creates a materia_prima.

  ## Examples

      iex> create_materia_prima(%{field: value})
      {:ok, %MateriaPrima{}}

      iex> create_materia_prima(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_materia_prima(attrs) do
    %MateriaPrima{}
    |> MateriaPrima.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a materia_prima.

  ## Examples

      iex> update_materia_prima(materia_prima, %{field: new_value})
      {:ok, %MateriaPrima{}}

      iex> update_materia_prima(materia_prima, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_materia_prima(%MateriaPrima{} = materia_prima, attrs) do
    materia_prima
    |> MateriaPrima.changeset(attrs)
    |> Repo.update()
  end

  def deactivate_materia_prima(%MateriaPrima{} = materia_prima) do
    update_materia_prima(materia_prima, %{activo: false})
  end

  @doc """
  Deletes a materia_prima.

  ## Examples

      iex> delete_materia_prima(materia_prima)
      {:ok, %MateriaPrima{}}

      iex> delete_materia_prima(materia_prima)
      {:error, %Ecto.Changeset{}}

  """
  def delete_materia_prima(%MateriaPrima{} = materia_prima) do
    deactivate_materia_prima(materia_prima)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking materia_prima changes.

  ## Examples

      iex> change_materia_prima(materia_prima)
      %Ecto.Changeset{data: %MateriaPrima{}}

  """
  def change_materia_prima(%MateriaPrima{} = materia_prima, attrs \\ %{}) do
    MateriaPrima.changeset(materia_prima, attrs)
  end
end
