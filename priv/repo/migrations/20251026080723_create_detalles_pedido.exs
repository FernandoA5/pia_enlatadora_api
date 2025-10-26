defmodule EnlatadoraApi.Repo.Migrations.CreateDetallesPedido do
  use Ecto.Migration

  @disable_ddl_transaction true
  @schema "Pedido"

  def up do
    execute("IF SCHEMA_ID('#{@schema}') IS NULL EXEC('CREATE SCHEMA #{@schema}');")

    create table(:detalles_pedido, prefix: @schema) do
      add :cantidad, :decimal, precision: 10, scale: 2, null: false
      add :precio_unitario, :decimal, precision: 10, scale: 2, null: false
      add :activo, :boolean, default: false, null: false
      add :id_pedido, references(:pedidos, on_delete: :nothing, prefix: @schema), null: false
      add :id_producto, references(:productos, on_delete: :nothing, prefix: :Catalogo), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:detalles_pedido, [:id_pedido], prefix: @schema)
    create index(:detalles_pedido, [:id_producto], prefix: @schema)
  end

  def down do
    drop_if_exists index(:detalles_pedido, [:id_producto], prefix: @schema)
    drop_if_exists index(:detalles_pedido, [:id_pedido], prefix: @schema)
    drop_if_exists table(:detalles_pedido, prefix: @schema)
  end
end
