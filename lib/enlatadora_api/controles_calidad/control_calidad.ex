defmodule EnlatadoraApi.ControlesCalidad.ControlCalidad do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix :Produccion
  schema "controles_calidad" do
    field :fecha_control, :date
    field :resultado, :string
    field :observaciones, :string
    field :activo, :boolean, default: false
    field :id_produccion, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(control_calidad, attrs) do
    control_calidad
    |> cast(attrs, [:fecha_control, :resultado, :observaciones, :activo, :id_produccion])
    |> validate_required([:fecha_control, :resultado, :observaciones, :activo, :id_produccion])
  end
end
