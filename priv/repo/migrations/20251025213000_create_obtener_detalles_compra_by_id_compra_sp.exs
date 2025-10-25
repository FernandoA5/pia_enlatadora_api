defmodule EnlatadoraApi.Repo.Migrations.CreateObtenerDetallesCompraByIdCompraSp do
  use Ecto.Migration

  @disable_ddl_transaction true

  @procedure_name "Compras.obtener_detalles_compra_by_id_compra"

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
      @IdCompra BIGINT
    AS
    BEGIN
      SET NOCOUNT ON;

      SELECT
        detalle.id,
        detalle.cantidad,
        detalle.precio_unitario,
        detalle.id_compra,
        detalle.id_materia,
        materia.nombre AS materia
      FROM Compras.detalle_compras AS detalle
      LEFT JOIN Catalogo.materias_primas AS materia
        ON materia.id = detalle.id_materia
      WHERE detalle.id_compra = @IdCompra
        AND detalle.activo = 1;
    END');
    """
  end
end
