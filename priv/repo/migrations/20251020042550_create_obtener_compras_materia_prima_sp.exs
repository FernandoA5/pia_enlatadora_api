defmodule EnlatadoraApi.Repo.Migrations.CreateObtenerComprasMateriaPrimaSp do
  use Ecto.Migration

  @disable_ddl_transaction true

  @procedure_name "Compras.obtener_compras_materia_prima"

  def up do
    execute(drop_procedure_if_exists())
    execute(create_procedure())
  end

  def down do
    execute(drop_procedure_if_exists())
  end

  defp drop_procedure_if_exists do
    """
    IF OBJECT_ID('#{@procedure_name}', 'P') IS NOT NULL
      DROP PROCEDURE #{@procedure_name};
    """
  end

  defp create_procedure do
    """
    EXEC('CREATE PROCEDURE #{@procedure_name}
    AS
    BEGIN
      SET NOCOUNT ON;

      SELECT
        cmp.id AS id_compra,
        cmp.id_proveedor,
        prov.nombre AS nombre_proveedor,
        cmp.fecha_compra,
        cmp.total,
        cmp.activo
      FROM Compras.compras_materia_prima AS cmp
      LEFT JOIN Catalogo.proveedores AS prov
        ON prov.id = cmp.id_proveedor;
    END');
    """
  end
end
