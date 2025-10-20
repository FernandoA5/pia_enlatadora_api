defmodule EnlatadoraApi.Repo.Migrations.CreateClientes do
  use Ecto.Migration

  def change do
    create table(:clientes, prefix: :Catalogo) do
      add :nombre, :string
      add :telefono, :string
      add :direccion, :string
      add :correo, :string
      add :activo, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
