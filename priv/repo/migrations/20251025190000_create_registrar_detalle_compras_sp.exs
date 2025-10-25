defmodule EnlatadoraApi.Repo.Migrations.CreateRegistrarDetalleComprasSp do
  use Ecto.Migration

  @disable_ddl_transaction true

  @procedure_name "Compras.registrar_detalles_compra"
  @type_name "Compras.DetalleComprasItemsType"

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
      id_materia BIGINT NOT NULL,
      cantidad DECIMAL(18, 4) NOT NULL,
      precio_unitario DECIMAL(18, 4) NOT NULL
    );');
    """
  end

  defp create_procedure do
    """
    EXEC('CREATE PROCEDURE #{@procedure_name}
      @IdCompra BIGINT,
      @Detalles #{@type_name} READONLY
    AS
    BEGIN
      SET NOCOUNT ON;

      INSERT INTO Compras.detalle_compras (
        id_compra,
        id_materia,
        cantidad,
        precio_unitario,
        inserted_at,
        updated_at
      )
      SELECT
        @IdCompra,
        detalle.id_materia,
        detalle.cantidad,
        detalle.precio_unitario,
        SYSUTCDATETIME(),
        SYSUTCDATETIME()
      FROM @Detalles AS detalle;
    END');
    """
  end
end
