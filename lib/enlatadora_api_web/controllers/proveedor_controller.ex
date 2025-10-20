defmodule EnlatadoraApiWeb.ProveedorController do
  use EnlatadoraApiWeb, :controller

  alias EnlatadoraApi.Proveedores
  alias EnlatadoraApi.Proveedores.Proveedor

  action_fallback EnlatadoraApiWeb.FallbackController

  def index(conn, _params) do
    proveedores = Proveedores.list_proveedores()
    render(conn, :index, proveedores: proveedores)
  end

  def create(conn, %{"proveedor" => proveedor_params}) do
    with {:ok, %Proveedor{} = proveedor} <- Proveedores.create_proveedor(proveedor_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/proveedores/#{proveedor}")
      |> render(:show, proveedor: proveedor)
    end
  end

  def show(conn, %{"id" => id}) do
    proveedor = Proveedores.get_proveedor!(id)
    render(conn, :show, proveedor: proveedor)
  end

  def update(conn, %{"id" => id, "proveedor" => proveedor_params}) do
    proveedor = Proveedores.get_proveedor!(id)

    with {:ok, %Proveedor{} = proveedor} <- Proveedores.update_proveedor(proveedor, proveedor_params) do
      render(conn, :show, proveedor: proveedor)
    end
  end

  def delete(conn, %{"id" => id}) do
    proveedor = Proveedores.get_proveedor!(id)

    with {:ok, %Proveedor{}} <- Proveedores.delete_proveedor(proveedor) do
      send_resp(conn, :no_content, "")
    end
  end
end
