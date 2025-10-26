defmodule EnlatadoraApiWeb.PedidoController do
  use EnlatadoraApiWeb, :controller

  alias EnlatadoraApi.Pedidos
  alias EnlatadoraApi.Pedidos.Pedido

  action_fallback EnlatadoraApiWeb.FallbackController

  def index(conn, _params) do
    pedidos = Pedidos.list_pedidos()
    render(conn, :index, pedidos: pedidos)
  end

  def create(conn, %{"pedido" => pedido_params}) do
    with {:ok, %Pedido{} = pedido} <- Pedidos.create_pedido(pedido_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/pedidos/#{pedido}")
      |> render(:show, pedido: pedido)
    end
  end

  def show(conn, %{"id" => id}) do
    pedido = Pedidos.get_pedido!(id)
    render(conn, :show, pedido: pedido)
  end

  def update(conn, %{"id" => id, "pedido" => pedido_params}) do
    pedido = Pedidos.get_pedido!(id)

    with {:ok, %Pedido{} = pedido} <- Pedidos.update_pedido(pedido, pedido_params) do
      render(conn, :show, pedido: pedido)
    end
  end

  def delete(conn, %{"id" => id}) do
    pedido = Pedidos.get_pedido!(id)

    with {:ok, %Pedido{}} <- Pedidos.delete_pedido(pedido) do
      send_resp(conn, :no_content, "")
    end
  end

  def obtener_pedidos(conn, _params) do
    with {:ok, pedidos} <- Pedidos.obtener_pedidos() do
      json(conn, %{data: pedidos})
    end
  end
end
