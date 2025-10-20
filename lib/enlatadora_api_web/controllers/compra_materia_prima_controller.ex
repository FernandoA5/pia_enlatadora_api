defmodule EnlatadoraApiWeb.CompraMateriaPrimaController do
  use EnlatadoraApiWeb, :controller

  alias EnlatadoraApi.Compras
  alias EnlatadoraApi.Compras.CompraMateriaPrima

  action_fallback EnlatadoraApiWeb.FallbackController

  def index(conn, _params) do
    compras_materia_prima = Compras.list_compras_materia_prima()
    render(conn, :index, compras_materia_prima: compras_materia_prima)
  end

  def create(conn, %{"compra_materia_prima" => compra_materia_prima_params}) do
    with {:ok, %CompraMateriaPrima{} = compra_materia_prima} <- Compras.create_compra_materia_prima(compra_materia_prima_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/compras_materia_prima/#{compra_materia_prima}")
      |> render(:show, compra_materia_prima: compra_materia_prima)
    end
  end

  def show(conn, %{"id" => id}) do
    compra_materia_prima = Compras.get_compra_materia_prima!(id)
    render(conn, :show, compra_materia_prima: compra_materia_prima)
  end

  def update(conn, %{"id" => id, "compra_materia_prima" => compra_materia_prima_params}) do
    compra_materia_prima = Compras.get_compra_materia_prima!(id)

    with {:ok, %CompraMateriaPrima{} = compra_materia_prima} <- Compras.update_compra_materia_prima(compra_materia_prima, compra_materia_prima_params) do
      render(conn, :show, compra_materia_prima: compra_materia_prima)
    end
  end

  def delete(conn, %{"id" => id}) do
    compra_materia_prima = Compras.get_compra_materia_prima!(id)

    with {:ok, %CompraMateriaPrima{}} <- Compras.delete_compra_materia_prima(compra_materia_prima) do
      send_resp(conn, :no_content, "")
    end
  end

  def obtener_compras_materia_prima(conn, _params) do
    with {:ok, resultado} <- Compras.obtener_compras_materia_prima() do
      render(conn, :show, compra_materia_prima: resultado)
    end
  end
end
