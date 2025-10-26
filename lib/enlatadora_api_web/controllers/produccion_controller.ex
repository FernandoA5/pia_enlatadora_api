defmodule EnlatadoraApiWeb.ProduccionController do
  use EnlatadoraApiWeb, :controller

  alias EnlatadoraApi.Producciones
  alias EnlatadoraApi.Producciones.Produccion

  action_fallback EnlatadoraApiWeb.FallbackController

  def index(conn, _params) do
    producciones = Producciones.list_producciones()
    render(conn, :index, producciones: producciones)
  end

  def create(conn, %{"produccion" => produccion_params}) do
    with {:ok, %Produccion{} = produccion} <- Producciones.create_produccion(produccion_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/producciones/#{produccion}")
      |> render(:show, produccion: produccion)
    end
  end

  def show(conn, %{"id" => id}) do
    produccion = Producciones.get_produccion!(id)
    render(conn, :show, produccion: produccion)
  end

  def obtener_producciones(conn, _params) do
    with {:ok, resultado} <- Producciones.obtener_producciones() do
      render(conn, :show, produccion: resultado)
    end
  end

  def update(conn, %{"id" => id, "produccion" => produccion_params}) do
    produccion = Producciones.get_produccion!(id)

    with {:ok, %Produccion{} = produccion} <- Producciones.update_produccion(produccion, produccion_params) do
      render(conn, :show, produccion: produccion)
    end
  end

  def delete(conn, %{"id" => id}) do
    produccion = Producciones.get_produccion!(id)

    with {:ok, %Produccion{}} <- Producciones.delete_produccion(produccion) do
      send_resp(conn, :no_content, "")
    end
  end
end
