defmodule EnlatadoraApi.DetalleCompras.DetalleCompra do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix :Compras
  schema "detalle_compras" do
    field :cantidad, :decimal
    field :precio_unitario, :decimal
    field :id_compra, :id
    field :id_materia, :id
    field :activo, :boolean, default: true

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(detalle_compra, attrs) do
    detalle_compra
    |> cast(attrs, [:cantidad, :precio_unitario, :activo])
    |> validate_required([:cantidad, :precio_unitario, :activo])
  end
end
