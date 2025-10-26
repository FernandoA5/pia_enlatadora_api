defmodule EnlatadoraApi.Repo.Migrations.CreateProducciones do
  use Ecto.Migration

  @disable_ddl_transaction true
  @schema "Produccion"

  def up do
    execute("IF SCHEMA_ID('#{@schema}') IS NULL EXEC('CREATE SCHEMA #{@schema}');")

    create table(:producciones, prefix: @schema) do
      add :fecha_produccion, :date
      add :cantidad_producida, :decimal
      add :estado, :string
      add :activo, :boolean, default: false, null: false
      add :id_producto, references(:productos, on_delete: :nothing, prefix: "Catalogo")

      timestamps(type: :utc_datetime)
    end

    create index(:producciones, [:id_producto], prefix: @schema)
  end

  def down do
    drop_if_exists index(:producciones, [:id_producto], prefix: @schema)
    drop_if_exists table(:producciones, prefix: @schema)
    execute("IF SCHEMA_ID('#{@schema}') IS NOT NULL EXEC('DROP SCHEMA #{@schema}');")
  end
end
