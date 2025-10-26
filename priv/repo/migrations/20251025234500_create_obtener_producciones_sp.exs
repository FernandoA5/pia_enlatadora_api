defmodule EnlatadoraApi.Repo.Migrations.CreateObtenerProduccionesSp do
  use Ecto.Migration

  @disable_ddl_transaction true

  @procedure_name "Produccion.obtener_producciones"

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
        producto.nombre AS nombre_producto,
        prod.cantidad_producida,
        prod.estado,
        prod.fecha_produccion,
        prod.id,
        prod.activo,
        prod.id_producto
      FROM Produccion.producciones AS prod
      LEFT JOIN Catalogo.productos AS producto
        ON producto.id = prod.id_producto;
    END');
    """
  end
end
