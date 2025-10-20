defmodule EnlatadoraApiWeb.MateriaPrimaControllerTest do
  use EnlatadoraApiWeb.ConnCase

  import EnlatadoraApi.MateriasPrimasFixtures
  alias EnlatadoraApi.MateriasPrimas.MateriaPrima

  @create_attrs %{
    nombre: "some nombre",
    descripcion: "some descripcion",
    unidad_medida: "some unidad_medida",
    stock_actual: "120.5",
    stock_minimo: "120.5"
  }
  @update_attrs %{
    nombre: "some updated nombre",
    descripcion: "some updated descripcion",
    unidad_medida: "some updated unidad_medida",
    stock_actual: "456.7",
    stock_minimo: "456.7"
  }
  @invalid_attrs %{nombre: nil, descripcion: nil, unidad_medida: nil, stock_actual: nil, stock_minimo: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all materias_primas", %{conn: conn} do
      conn = get(conn, ~p"/api/materias_primas")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create materia_prima" do
    test "renders materia_prima when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/materias_primas", materia_prima: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/materias_primas/#{id}")

      assert %{
               "id" => ^id,
               "descripcion" => "some descripcion",
               "nombre" => "some nombre",
               "stock_actual" => "120.5",
               "stock_minimo" => "120.5",
               "unidad_medida" => "some unidad_medida"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/materias_primas", materia_prima: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update materia_prima" do
    setup [:create_materia_prima]

    test "renders materia_prima when data is valid", %{conn: conn, materia_prima: %MateriaPrima{id: id} = materia_prima} do
      conn = put(conn, ~p"/api/materias_primas/#{materia_prima}", materia_prima: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/materias_primas/#{id}")

      assert %{
               "id" => ^id,
               "descripcion" => "some updated descripcion",
               "nombre" => "some updated nombre",
               "stock_actual" => "456.7",
               "stock_minimo" => "456.7",
               "unidad_medida" => "some updated unidad_medida"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, materia_prima: materia_prima} do
      conn = put(conn, ~p"/api/materias_primas/#{materia_prima}", materia_prima: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete materia_prima" do
    setup [:create_materia_prima]

    test "deletes chosen materia_prima", %{conn: conn, materia_prima: materia_prima} do
      conn = delete(conn, ~p"/api/materias_primas/#{materia_prima}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/materias_primas/#{materia_prima}")
      end
    end
  end

  defp create_materia_prima(_) do
    materia_prima = materia_prima_fixture()

    %{materia_prima: materia_prima}
  end
end
