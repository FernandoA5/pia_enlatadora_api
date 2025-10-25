defmodule EnlatadoraApi.Repo.Migrations.CreateDetalleCompras do
  use Ecto.Migration

  def change do
    create table(:detalle_compras, prefix: :Compras) do
      add :cantidad, :decimal
      add :precio_unitario, :decimal
      add :id_compra, references(:compras_materia_prima, on_delete: :nothing, prefix: :Compras)
      add :id_materia, references(:materias_primas, on_delete: :nothing, prefix: :Catalogo)
      add :activo, :boolean, default: true, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:detalle_compras, [:id_compra], prefix: :Compras)
    create index(:detalle_compras, [:id_materia], prefix: :Compras)
  end
end
