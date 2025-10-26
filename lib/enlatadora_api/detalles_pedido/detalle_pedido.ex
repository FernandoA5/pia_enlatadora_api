defmodule EnlatadoraApi.DetallesPedido.DetallePedido do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix :Pedido
  schema "detalles_pedido" do
    field :cantidad, :decimal
    field :precio_unitario, :decimal
    field :activo, :boolean, default: false
    field :id_pedido, :id
    field :id_producto, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(detalle_pedido, attrs) do
    detalle_pedido
    |> cast(attrs, [:cantidad, :precio_unitario, :activo])
    |> validate_required([:cantidad, :precio_unitario, :activo])
  end
end
