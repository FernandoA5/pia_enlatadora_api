defmodule EnlatadoraApiWeb.CompraMateriaPrimaControllerTest do
  use EnlatadoraApiWeb.ConnCase

  import EnlatadoraApi.ComprasFixtures
  alias EnlatadoraApi.Compras.CompraMateriaPrima

  @create_attrs %{
    total: "120.5",
    fecha_compra: ~D[2025-10-19],
    activo: true
  }
  @update_attrs %{
    total: "456.7",
    fecha_compra: ~D[2025-10-20],
    activo: false
  }
  @invalid_attrs %{total: nil, fecha_compra: nil, activo: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all compras_materia_prima", %{conn: conn} do
      conn = get(conn, ~p"/api/compras_materia_prima")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create compra_materia_prima" do
    test "renders compra_materia_prima when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/compras_materia_prima", compra_materia_prima: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/compras_materia_prima/#{id}")

      assert %{
               "id" => ^id,
               "activo" => true,
               "fecha_compra" => "2025-10-19",
               "total" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/compras_materia_prima", compra_materia_prima: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update compra_materia_prima" do
    setup [:create_compra_materia_prima]

    test "renders compra_materia_prima when data is valid", %{conn: conn, compra_materia_prima: %CompraMateriaPrima{id: id} = compra_materia_prima} do
      conn = put(conn, ~p"/api/compras_materia_prima/#{compra_materia_prima}", compra_materia_prima: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/compras_materia_prima/#{id}")

      assert %{
               "id" => ^id,
               "activo" => false,
               "fecha_compra" => "2025-10-20",
               "total" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, compra_materia_prima: compra_materia_prima} do
      conn = put(conn, ~p"/api/compras_materia_prima/#{compra_materia_prima}", compra_materia_prima: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete compra_materia_prima" do
    setup [:create_compra_materia_prima]

    test "deletes chosen compra_materia_prima", %{conn: conn, compra_materia_prima: compra_materia_prima} do
      conn = delete(conn, ~p"/api/compras_materia_prima/#{compra_materia_prima}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/compras_materia_prima/#{compra_materia_prima}")
      end
    end
  end

  defp create_compra_materia_prima(_) do
    compra_materia_prima = compra_materia_prima_fixture()

    %{compra_materia_prima: compra_materia_prima}
  end
end
