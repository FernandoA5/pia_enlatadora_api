defmodule EnlatadoraApi.Repo.Migrations.CreateObtenerControlCalidadPorProduccionSp do
  use Ecto.Migration

  @disable_ddl_transaction true
  @procedure_name "Produccion.obtener_control_calidad_por_produccion"

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
      @IdProduccion BIGINT
    AS
    BEGIN
      SET NOCOUNT ON;

      SELECT TOP 1
        c.id,
        c.resultado,
        c.observaciones,
        c.fecha_control,
        c.activo,
        c.id_produccion
      FROM Produccion.controles_calidad AS c
      WHERE c.id_produccion = @IdProduccion
      ORDER BY c.fecha_control DESC, c.id DESC;
    END');
    """
  end
end
