defmodule EnlatadoraApiWeb.DetallePedidoController do
  use EnlatadoraApiWeb, :controller

  alias EnlatadoraApi.DetallesPedido
  alias EnlatadoraApi.DetallesPedido.DetallePedido

  action_fallback EnlatadoraApiWeb.FallbackController

  def index(conn, _params) do
    detalles_pedido = DetallesPedido.list_detalles_pedido()
    render(conn, :index, detalles_pedido: detalles_pedido)
  end

  def create(conn, %{"detalle_pedido" => detalle_pedido_params}) do
    with {:ok, %DetallePedido{} = detalle_pedido} <- DetallesPedido.create_detalle_pedido(detalle_pedido_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/detalles_pedido/#{detalle_pedido}")
      |> render(:show, detalle_pedido: detalle_pedido)
    end
  end

  def show(conn, %{"id" => id}) do
    detalle_pedido = DetallesPedido.get_detalle_pedido!(id)
    render(conn, :show, detalle_pedido: detalle_pedido)
  end

  def update(conn, %{"id" => id, "detalle_pedido" => detalle_pedido_params}) do
    detalle_pedido = DetallesPedido.get_detalle_pedido!(id)

    with {:ok, %DetallePedido{} = detalle_pedido} <- DetallesPedido.update_detalle_pedido(detalle_pedido, detalle_pedido_params) do
      render(conn, :show, detalle_pedido: detalle_pedido)
    end
  end

  def delete(conn, %{"id" => id}) do
    detalle_pedido = DetallesPedido.get_detalle_pedido!(id)

    with {:ok, %DetallePedido{}} <- DetallesPedido.delete_detalle_pedido(detalle_pedido) do
      send_resp(conn, :no_content, "")
    end
  end

  def registrar_detalles_pedido(conn, params) do
    with {:ok, result} <- DetallesPedido.registrar_detalles_pedido(params) do
      json(conn, %{data: result})
    end
  end

  def obtener_detalles_pedido_by_id_pedido(conn, params) do
    attrs = Map.take(params, ["id_pedido"])

    with {:ok, result} <- DetallesPedido.obtener_detalles_por_pedido(attrs) do
      json(conn, %{data: result})
    end
  end
end
