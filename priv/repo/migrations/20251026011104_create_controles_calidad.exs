defmodule EnlatadoraApi.Repo.Migrations.CreateControlesCalidad do
  use Ecto.Migration

  @disable_ddl_transaction true
  @schema "Produccion"

  def up do
    execute("IF SCHEMA_ID('#{@schema}') IS NULL EXEC('CREATE SCHEMA #{@schema}');")

    create table(:controles_calidad, prefix: @schema) do
      add :fecha_control, :date, null: false
      add :resultado, :string, null: false
      add :observaciones, :string
      add :activo, :boolean, default: false, null: false
      add :id_produccion, references(:producciones, on_delete: :nothing, prefix: @schema), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:controles_calidad, [:id_produccion], prefix: @schema)
  end

  def down do
    drop_if_exists index(:controles_calidad, [:id_produccion], prefix: @schema)
    drop_if_exists table(:controles_calidad, prefix: @schema)
  end
end
