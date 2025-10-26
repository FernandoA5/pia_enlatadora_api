defmodule EnlatadoraApi.Producciones.Produccion do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix :Produccion
  schema "producciones" do
    field :fecha_produccion, :date
    field :cantidad_producida, :decimal
    field :estado, :string
    field :activo, :boolean, default: false
    field :id_producto, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(produccion, attrs) do
    produccion
    |> cast(attrs, [:fecha_produccion, :cantidad_producida, :estado, :activo, :id_producto])
    |> validate_required([:fecha_produccion, :cantidad_producida, :estado, :activo, :id_producto])
  end
end
