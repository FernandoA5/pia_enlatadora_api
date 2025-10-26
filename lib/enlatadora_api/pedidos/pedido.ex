defmodule EnlatadoraApi.Pedidos.Pedido do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix :Pedido
  schema "pedidos" do
    field :fecha_pedido, :date
    field :total, :decimal
    field :activo, :boolean, default: false
    field :id_cliente, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(pedido, attrs) do
    pedido
    |> cast(attrs, [:fecha_pedido, :total, :activo, :id_cliente])
    |> validate_required([:fecha_pedido, :total, :activo, :id_cliente])
  end
end
