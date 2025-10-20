defmodule EnlatadoraApi.Repo.Migrations.CreateComprasMateriaPrima do
  use Ecto.Migration

  def change do
    create table(:compras_materia_prima, prefix: :Compras) do
      add :fecha_compra, :date
      add :total, :decimal
      add :activo, :boolean, default: false, null: false
      add :id_proveedor, references(:proveedores, on_delete: :nothing, prefix: :Catalogo)

      timestamps(type: :utc_datetime)
    end

    create index(:compras_materia_prima, [:id_proveedor], prefix: :Compras)
  end
end
