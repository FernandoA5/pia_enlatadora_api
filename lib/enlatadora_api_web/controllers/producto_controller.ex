defmodule EnlatadoraApiWeb.ProductoController do
  use EnlatadoraApiWeb, :controller

  alias EnlatadoraApi.Productos
  alias EnlatadoraApi.Productos.Producto

  action_fallback EnlatadoraApiWeb.FallbackController

  def index(conn, _params) do
    productos = Productos.list_productos()
    render(conn, :index, productos: productos)
  end

  def create(conn, %{"producto" => producto_params}) do
    with {:ok, %Producto{} = producto} <- Productos.create_producto(producto_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/productos/#{producto}")
      |> render(:show, producto: producto)
    end
  end

  def show(conn, %{"id" => id}) do
    producto = Productos.get_producto!(id)
    render(conn, :show, producto: producto)
  end

  def update(conn, %{"id" => id, "producto" => producto_params}) do
    producto = Productos.get_producto!(id)

    with {:ok, %Producto{} = producto} <- Productos.update_producto(producto, producto_params) do
      render(conn, :show, producto: producto)
    end
  end

  def delete(conn, %{"id" => id}) do
    producto = Productos.get_producto!(id)

    with {:ok, %Producto{}} <- Productos.delete_producto(producto) do
      send_resp(conn, :no_content, "")
    end
  end
end
