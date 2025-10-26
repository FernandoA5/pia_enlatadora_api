defmodule EnlatadoraApiWeb.DetallePedidoControllerTest do
  use EnlatadoraApiWeb.ConnCase

  import EnlatadoraApi.DetallesPedidoFixtures
  alias EnlatadoraApi.DetallesPedido.DetallePedido

  @create_attrs %{
    cantidad: "120.5",
    precio_unitario: "120.5",
    activo: true
  }
  @update_attrs %{
    cantidad: "456.7",
    precio_unitario: "456.7",
    activo: false
  }
  @invalid_attrs %{cantidad: nil, precio_unitario: nil, activo: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all detalles_pedido", %{conn: conn} do
      conn = get(conn, ~p"/api/detalles_pedido")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create detalle_pedido" do
    test "renders detalle_pedido when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/detalles_pedido", detalle_pedido: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/detalles_pedido/#{id}")

      assert %{
               "id" => ^id,
               "activo" => true,
               "cantidad" => "120.5",
               "precio_unitario" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/detalles_pedido", detalle_pedido: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update detalle_pedido" do
    setup [:create_detalle_pedido]

    test "renders detalle_pedido when data is valid", %{conn: conn, detalle_pedido: %DetallePedido{id: id} = detalle_pedido} do
      conn = put(conn, ~p"/api/detalles_pedido/#{detalle_pedido}", detalle_pedido: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/detalles_pedido/#{id}")

      assert %{
               "id" => ^id,
               "activo" => false,
               "cantidad" => "456.7",
               "precio_unitario" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, detalle_pedido: detalle_pedido} do
      conn = put(conn, ~p"/api/detalles_pedido/#{detalle_pedido}", detalle_pedido: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete detalle_pedido" do
    setup [:create_detalle_pedido]

    test "deletes chosen detalle_pedido", %{conn: conn, detalle_pedido: detalle_pedido} do
      conn = delete(conn, ~p"/api/detalles_pedido/#{detalle_pedido}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/detalles_pedido/#{detalle_pedido}")
      end
    end
  end

  defp create_detalle_pedido(_) do
    detalle_pedido = detalle_pedido_fixture()

    %{detalle_pedido: detalle_pedido}
  end
end
