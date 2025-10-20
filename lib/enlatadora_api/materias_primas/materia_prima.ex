defmodule EnlatadoraApi.MateriasPrimas.MateriaPrima do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix :Catalogo
  schema "materias_primas" do
    field :nombre, :string
    field :descripcion, :string
    field :unidad_medida, :string
    field :stock_actual, :decimal
    field :stock_minimo, :decimal
    field :activo, :boolean, default: true

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(materia_prima, attrs) do
    materia_prima
    |> cast(attrs, [:nombre, :descripcion, :unidad_medida, :stock_actual, :stock_minimo, :activo])
    |> validate_required([:nombre, :descripcion, :unidad_medida, :stock_actual, :stock_minimo, :activo])
  end
end
