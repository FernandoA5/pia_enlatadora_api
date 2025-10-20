defmodule EnlatadoraApi.Repo.Migrations.CreateProductos do
  use Ecto.Migration

  def change do
    create table(:productos, prefix: :Catalogo) do
      add :nombre, :string
      add :descripcion, :string
      add :unidad_medida, :string
      add :stock_actual, :decimal
      add :activo, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
