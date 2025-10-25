defmodule EnlatadoraApiWeb.DetalleCompraControllerTest do
  use EnlatadoraApiWeb.ConnCase

  import EnlatadoraApi.DetalleComprasFixtures
  alias EnlatadoraApi.DetalleCompras.DetalleCompra

  @create_attrs %{
    cantidad: "120.5",
    precio_unitario: "120.5"
  }
  @update_attrs %{
    cantidad: "456.7",
    precio_unitario: "456.7"
  }
  @invalid_attrs %{cantidad: nil, precio_unitario: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all detalle_compras", %{conn: conn} do
      conn = get(conn, ~p"/api/detalle_compras")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create detalle_compra" do
    test "renders detalle_compra when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/detalle_compras", detalle_compra: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/detalle_compras/#{id}")

      assert %{
               "id" => ^id,
               "cantidad" => "120.5",
               "precio_unitario" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/detalle_compras", detalle_compra: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update detalle_compra" do
    setup [:create_detalle_compra]

    test "renders detalle_compra when data is valid", %{conn: conn, detalle_compra: %DetalleCompra{id: id} = detalle_compra} do
      conn = put(conn, ~p"/api/detalle_compras/#{detalle_compra}", detalle_compra: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/detalle_compras/#{id}")

      assert %{
               "id" => ^id,
               "cantidad" => "456.7",
               "precio_unitario" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, detalle_compra: detalle_compra} do
      conn = put(conn, ~p"/api/detalle_compras/#{detalle_compra}", detalle_compra: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete detalle_compra" do
    setup [:create_detalle_compra]

    test "deletes chosen detalle_compra", %{conn: conn, detalle_compra: detalle_compra} do
      conn = delete(conn, ~p"/api/detalle_compras/#{detalle_compra}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/detalle_compras/#{detalle_compra}")
      end
    end
  end

  defp create_detalle_compra(_) do
    detalle_compra = detalle_compra_fixture()

    %{detalle_compra: detalle_compra}
  end
end
