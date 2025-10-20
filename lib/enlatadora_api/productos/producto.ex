defmodule EnlatadoraApi.Productos.Producto do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix :Catalogo
  schema "productos" do
    field :nombre, :string
    field :descripcion, :string
    field :unidad_medida, :string
    field :stock_actual, :decimal
    field :activo, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(producto, attrs) do
    producto
    |> cast(attrs, [:nombre, :descripcion, :unidad_medida, :stock_actual, :activo])
    |> validate_required([:nombre, :descripcion, :unidad_medida, :stock_actual, :activo])
  end
end
