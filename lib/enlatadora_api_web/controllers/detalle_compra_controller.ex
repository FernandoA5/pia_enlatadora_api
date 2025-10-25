defmodule EnlatadoraApiWeb.DetalleCompraController do
  use EnlatadoraApiWeb, :controller

  alias EnlatadoraApi.DetalleCompras
  alias EnlatadoraApi.DetalleCompras.DetalleCompra

  action_fallback EnlatadoraApiWeb.FallbackController

  def index(conn, _params) do
    detalle_compras = DetalleCompras.list_detalle_compras()
    render(conn, :index, detalle_compras: detalle_compras)
  end

  def create(conn, %{"detalle_compra" => detalle_compra_params}) do
    with {:ok, %DetalleCompra{} = detalle_compra} <- DetalleCompras.create_detalle_compra(detalle_compra_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/detalle_compras/#{detalle_compra}")
      |> render(:show, detalle_compra: detalle_compra)
    end
  end

  def show(conn, %{"id" => id}) do
    detalle_compra = DetalleCompras.get_detalle_compra!(id)
    render(conn, :show, detalle_compra: detalle_compra)
  end

  def update(conn, %{"id" => id, "detalle_compra" => detalle_compra_params}) do
    detalle_compra = DetalleCompras.get_detalle_compra!(id)

    with {:ok, %DetalleCompra{} = detalle_compra} <- DetalleCompras.update_detalle_compra(detalle_compra, detalle_compra_params) do
      render(conn, :show, detalle_compra: detalle_compra)
    end
  end

  def delete(conn, %{"id" => id}) do
    detalle_compra = DetalleCompras.get_detalle_compra!(id)

    with {:ok, %DetalleCompra{}} <- DetalleCompras.delete_detalle_compra(detalle_compra) do
      send_resp(conn, :no_content, "")
    end
  end

  def registrar_detalles_compra(conn, params) do
    with {:ok, result} <- DetalleCompras.registrar_detalles_compra(params) do
      json(conn, %{data: result})
    end
  end

  def obtener_detalles_compra_by_id_compra(conn, params) do
    attrs = Map.take(params, ["id_compra"])

    with {:ok, result} <- DetalleCompras.obtener_detalles_por_compra(attrs) do
      json(conn, %{data: result})
    end
  end
end
