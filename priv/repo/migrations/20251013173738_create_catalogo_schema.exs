defmodule EnlatadoraApi.Repo.Migrations.CreateCatalogoSchema do
  use Ecto.Migration

  @disable_ddl_transaction true

  def up do
    execute("""
    IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Catalogo')
      EXEC('CREATE SCHEMA Catalogo');
    """)
  end

  def down do
    execute("""
    IF EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Catalogo')
      EXEC('DROP SCHEMA Catalogo');
    """)
  end
end
