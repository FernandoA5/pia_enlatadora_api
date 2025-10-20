defmodule EnlatadoraApiWeb.ClienteController do
  use EnlatadoraApiWeb, :controller

  alias EnlatadoraApi.Clientes
  alias EnlatadoraApi.Clientes.Cliente

  action_fallback EnlatadoraApiWeb.FallbackController

  def index(conn, _params) do
    clientes = Clientes.list_clientes()
    render(conn, :index, clientes: clientes)
  end

  def create(conn, %{"cliente" => cliente_params}) do
    with {:ok, %Cliente{} = cliente} <- Clientes.create_cliente(cliente_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clientes/#{cliente}")
      |> render(:show, cliente: cliente)
    end
  end

  def show(conn, %{"id" => id}) do
    cliente = Clientes.get_cliente!(id)
    render(conn, :show, cliente: cliente)
  end

  def update(conn, %{"id" => id, "cliente" => cliente_params}) do
    cliente = Clientes.get_cliente!(id)

    with {:ok, %Cliente{} = cliente} <- Clientes.update_cliente(cliente, cliente_params) do
      render(conn, :show, cliente: cliente)
    end
  end

  def delete(conn, %{"id" => id}) do
    cliente = Clientes.get_cliente!(id)

    with {:ok, %Cliente{}} <- Clientes.delete_cliente(cliente) do
      send_resp(conn, :no_content, "")
    end
  end
end
