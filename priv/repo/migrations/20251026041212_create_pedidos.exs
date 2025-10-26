defmodule EnlatadoraApi.Repo.Migrations.CreatePedidos do
  use Ecto.Migration

  @disable_ddl_transaction true
  @schema "Pedido"

  def up do
    execute("IF SCHEMA_ID('#{@schema}') IS NULL EXEC('CREATE SCHEMA #{@schema}');")

    create table(:pedidos, prefix: @schema) do
      add :fecha_pedido, :date, null: false
      add :total, :decimal, precision: 10, scale: 2, null: false
      add :activo, :boolean, default: false, null: false
      add :id_cliente, references(:clientes, on_delete: :nothing, prefix: "Catalogo"), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:pedidos, [:id_cliente], prefix: @schema)
  end

  def down do
    drop_if_exists index(:pedidos, [:id_cliente], prefix: @schema)
    drop_if_exists table(:pedidos, prefix: @schema)
    execute("IF SCHEMA_ID('#{@schema}') IS NOT NULL EXEC('DROP SCHEMA #{@schema}');")
  end
end
