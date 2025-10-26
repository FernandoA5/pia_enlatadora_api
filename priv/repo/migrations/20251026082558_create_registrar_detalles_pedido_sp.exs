defmodule EnlatadoraApi.Repo.Migrations.CreateRegistrarDetallesPedidoSp do
  use Ecto.Migration

  @disable_ddl_transaction true

  @procedure_name "Pedido.registrar_detalles_pedido"
  @type_name "Pedido.DetallesPedidoItemsType"

  def up do
    execute(drop_procedure_if_exists())
    execute(drop_type_if_exists())
    execute(create_type())
    execute(create_procedure())
  end

  def down do
    execute(drop_procedure_if_exists())
    execute(drop_type_if_exists())
  end

  defp drop_procedure_if_exists do
    """
    IF OBJECT_ID('#{@procedure_name}', 'P') IS NOT NULL
      DROP PROCEDURE #{@procedure_name};
    """
  end

  defp drop_type_if_exists do
    """
    IF TYPE_ID('#{@type_name}') IS NOT NULL
      DROP TYPE #{@type_name};
    """
  end

  defp create_type do
    """
    EXEC('CREATE TYPE #{@type_name} AS TABLE (
      id_producto BIGINT NOT NULL,
      cantidad DECIMAL(18, 4) NOT NULL,
      precio_unitario DECIMAL(18, 4) NOT NULL,
      activo BIT NOT NULL DEFAULT 1
    );');
    """
  end

  defp create_procedure do
    """
    EXEC('CREATE PROCEDURE #{@procedure_name}
      @IdPedido BIGINT,
      @Detalles #{@type_name} READONLY
    AS
    BEGIN
      SET NOCOUNT ON;

      INSERT INTO Pedido.detalles_pedido (
        id_pedido,
        id_producto,
        cantidad,
        precio_unitario,
        activo,
        inserted_at,
        updated_at
      )
      SELECT
        @IdPedido,
        detalle.id_producto,
        detalle.cantidad,
        detalle.precio_unitario,
        detalle.activo,
        SYSUTCDATETIME(),
        SYSUTCDATETIME()
      FROM @Detalles AS detalle;
    END');
    """
  end
end
