defmodule EnlatadoraApiWeb.ProduccionControllerTest do
  use EnlatadoraApiWeb.ConnCase

  import EnlatadoraApi.ProduccionesFixtures
  alias EnlatadoraApi.Producciones.Produccion

  @create_attrs %{
    fecha_produccion: ~D[2025-10-24],
    cantidad_producida: "120.5",
    estado: "some estado",
    activo: true
  }
  @update_attrs %{
    fecha_produccion: ~D[2025-10-25],
    cantidad_producida: "456.7",
    estado: "some updated estado",
    activo: false
  }
  @invalid_attrs %{fecha_produccion: nil, cantidad_producida: nil, estado: nil, activo: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all producciones", %{conn: conn} do
      conn = get(conn, ~p"/api/producciones")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create produccion" do
    test "renders produccion when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/producciones", produccion: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/producciones/#{id}")

      assert %{
               "id" => ^id,
               "activo" => true,
               "cantidad_producida" => "120.5",
               "estado" => "some estado",
               "fecha_produccion" => "2025-10-24"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/producciones", produccion: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update produccion" do
    setup [:create_produccion]

    test "renders produccion when data is valid", %{conn: conn, produccion: %Produccion{id: id} = produccion} do
      conn = put(conn, ~p"/api/producciones/#{produccion}", produccion: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/producciones/#{id}")

      assert %{
               "id" => ^id,
               "activo" => false,
               "cantidad_producida" => "456.7",
               "estado" => "some updated estado",
               "fecha_produccion" => "2025-10-25"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, produccion: produccion} do
      conn = put(conn, ~p"/api/producciones/#{produccion}", produccion: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete produccion" do
    setup [:create_produccion]

    test "deletes chosen produccion", %{conn: conn, produccion: produccion} do
      conn = delete(conn, ~p"/api/producciones/#{produccion}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/producciones/#{produccion}")
      end
    end
  end

  defp create_produccion(_) do
    produccion = produccion_fixture()

    %{produccion: produccion}
  end
end
