defmodule EnlatadoraApi.Clientes.Cliente do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix :Catalogo
  schema "clientes" do
    field :nombre, :string
    field :telefono, :string
    field :direccion, :string
    field :correo, :string
    field :activo, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cliente, attrs) do
    cliente
    |> cast(attrs, [:nombre, :telefono, :direccion, :correo, :activo])
    |> validate_required([:nombre, :telefono, :direccion, :correo, :activo])
  end
end
