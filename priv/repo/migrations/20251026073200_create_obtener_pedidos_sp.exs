defmodule EnlatadoraApi.Repo.Migrations.CreateObtenerPedidosSp do
  use Ecto.Migration

  @disable_ddl_transaction true

  @procedure_name "Pedido.obtener_pedidos"

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
        p.id,
        COALESCE(c.nombre, ''Sin cliente'') AS cliente,
        p.id_cliente,
        COALESCE((
          SELECT SUM(dp.cantidad * dp.precio_unitario)
          FROM Pedido.detalles_pedido AS dp
          WHERE dp.id_pedido = p.id
            AND dp.activo = 1
        ), 0) AS total,
        p.fecha_pedido,
        p.activo
      FROM Pedido.pedidos AS p
      LEFT JOIN Catalogo.clientes AS c
        ON c.id = p.id_cliente;
    END');
    """
  end
end
