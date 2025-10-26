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
        prov.nombre AS nombre_proveedor,
        COALESCE(SUM(detalle.cantidad * detalle.precio_unitario), 0) AS total,
        cmp.fecha_compra,
        cmp.id AS id_compra,
        cmp.id_proveedor,
        cmp.activo
      FROM Compras.compras_materia_prima AS cmp
      LEFT JOIN Catalogo.proveedores AS prov
        ON prov.id = cmp.id_proveedor
      LEFT JOIN Compras.detalle_compras AS detalle
        ON detalle.id_compra = cmp.id
        AND detalle.activo = 1
      GROUP BY
        cmp.id,
        cmp.id_proveedor,
        prov.nombre,
        cmp.fecha_compra,
        cmp.activo;
    END');
    """
  end
end
