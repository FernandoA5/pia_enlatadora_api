defmodule EnlatadoraApi.Repo.Migrations.CreateComprasSchema do
  use Ecto.Migration

  @disable_ddl_transaction true

  def up do
    execute("""
    IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Compras')
      EXEC('CREATE SCHEMA Compras');
    """)
  end

  def down do
    execute("""
    IF EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Compras')
      EXEC('DROP SCHEMA Compras');
    """)
  end
end
