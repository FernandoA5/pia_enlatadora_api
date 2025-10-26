defmodule EnlatadoraApiWeb.ControlCalidadController do
  use EnlatadoraApiWeb, :controller

  alias EnlatadoraApi.ControlesCalidad
  alias EnlatadoraApi.ControlesCalidad.ControlCalidad

  action_fallback EnlatadoraApiWeb.FallbackController

  def index(conn, _params) do
    controles_calidad = ControlesCalidad.list_controles_calidad()
    render(conn, :index, controles_calidad: controles_calidad)
  end

  def create(conn, %{"control_calidad" => control_calidad_params}) do
    with {:ok, %ControlCalidad{} = control_calidad} <- ControlesCalidad.create_control_calidad(control_calidad_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/controles_calidad/#{control_calidad}")
      |> render(:show, control_calidad: control_calidad)
    end
  end

  def show(conn, %{"id" => id}) do
    control_calidad = ControlesCalidad.get_control_calidad!(id)
    render(conn, :show, control_calidad: control_calidad)
  end

  def update(conn, %{"id" => id, "control_calidad" => control_calidad_params}) do
    control_calidad = ControlesCalidad.get_control_calidad!(id)

    with {:ok, %ControlCalidad{} = control_calidad} <- ControlesCalidad.update_control_calidad(control_calidad, control_calidad_params) do
      render(conn, :show, control_calidad: control_calidad)
    end
  end

  def delete(conn, %{"id" => id}) do
    control_calidad = ControlesCalidad.get_control_calidad!(id)

    with {:ok, %ControlCalidad{}} <- ControlesCalidad.delete_control_calidad(control_calidad) do
      send_resp(conn, :no_content, "")
    end
  end

  def obtener_control_calidad_por_produccion(conn, params) do
    with {:ok, control} <- ControlesCalidad.obtener_control_calidad_por_produccion(params) do
      render(conn, :show, control_calidad: control)
    end
  end
end
