defmodule EnlatadoraApiWeb.MateriaPrimaController do
  use EnlatadoraApiWeb, :controller

  alias EnlatadoraApi.MateriasPrimas
  alias EnlatadoraApi.MateriasPrimas.MateriaPrima

  action_fallback EnlatadoraApiWeb.FallbackController

  def index(conn, _params) do
    materias_primas = MateriasPrimas.list_materias_primas()
    render(conn, :index, materias_primas: materias_primas)
  end

  def create(conn, %{"materia_prima" => materia_prima_params}) do
    with {:ok, %MateriaPrima{} = materia_prima} <- MateriasPrimas.create_materia_prima(materia_prima_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/materias_primas/#{materia_prima}")
      |> render(:show, materia_prima: materia_prima)
    end
  end

  def show(conn, %{"id" => id}) do
    materia_prima = MateriasPrimas.get_materia_prima!(id)
    render(conn, :show, materia_prima: materia_prima)
  end

  def update(conn, %{"id" => id, "materia_prima" => materia_prima_params}) do
    materia_prima = MateriasPrimas.get_materia_prima!(id)

    with {:ok, %MateriaPrima{} = materia_prima} <- MateriasPrimas.update_materia_prima(materia_prima, materia_prima_params) do
      render(conn, :show, materia_prima: materia_prima)
    end
  end

  def delete(conn, %{"id" => id}) do
    materia_prima = MateriasPrimas.get_materia_prima!(id)

    with {:ok, %MateriaPrima{}} <- MateriasPrimas.delete_materia_prima(materia_prima) do
      send_resp(conn, :no_content, "")
    end
  end
end
