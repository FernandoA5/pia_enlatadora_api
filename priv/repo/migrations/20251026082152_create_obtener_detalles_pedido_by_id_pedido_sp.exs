defmodule EnlatadoraApi.Repo.Migrations.CreateObtenerDetallesPedidoByIdPedidoSp do
  use Ecto.Migration

  @disable_ddl_transaction true

  @procedure_name "Pedido.obtener_detalles_pedido_by_id_pedido"

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
      @IdPedido BIGINT
    AS
    BEGIN
      SET NOCOUNT ON;

      SELECT
        detalle.id,
        detalle.cantidad,
        detalle.precio_unitario,
        detalle.id_pedido,
        detalle.id_producto,
        producto.nombre AS producto
      FROM Pedido.detalles_pedido AS detalle
      LEFT JOIN Catalogo.productos AS producto
        ON producto.id = detalle.id_producto
      WHERE detalle.id_pedido = @IdPedido
        AND detalle.activo = 1;
    END');
    """
  end
end
