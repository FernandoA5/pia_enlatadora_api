defmodule EnlatadoraApi.Repo.Migrations.CreateMateriasPrimas do
  use Ecto.Migration

  def change do
    create table(:materias_primas, prefix: :Catalogo) do
      add :nombre, :string
      add :descripcion, :string
      add :unidad_medida, :string
      add :stock_actual, :decimal
      add :stock_minimo, :decimal
      add :activo, :boolean, default: true, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
