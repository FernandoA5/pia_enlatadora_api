defmodule EnlatadoraApi.Compras.CompraMateriaPrima do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix :Compras
  schema "compras_materia_prima" do
    field :fecha_compra, :date
    field :total, :decimal
    field :activo, :boolean, default: false
    field :id_proveedor, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(compra_materia_prima, attrs) do
    compra_materia_prima
    |> cast(attrs, [:fecha_compra, :total, :activo, :id_proveedor])
    |> validate_required([:fecha_compra, :total, :activo, :id_proveedor])
  end
end
