defmodule EnlatadoraApiWeb.PedidoControllerTest do
  use EnlatadoraApiWeb.ConnCase

  import EnlatadoraApi.PedidosFixtures
  alias EnlatadoraApi.Pedidos.Pedido

  @create_attrs %{
    total: "120.5",
    fecha_pedido: ~D[2025-10-25],
    activo: true
  }
  @update_attrs %{
    total: "456.7",
    fecha_pedido: ~D[2025-10-26],
    activo: false
  }
  @invalid_attrs %{total: nil, fecha_pedido: nil, activo: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pedidos", %{conn: conn} do
      conn = get(conn, ~p"/api/pedidos")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pedido" do
    test "renders pedido when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/pedidos", pedido: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/pedidos/#{id}")

      assert %{
               "id" => ^id,
               "activo" => true,
               "fecha_pedido" => "2025-10-25",
               "total" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/pedidos", pedido: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pedido" do
    setup [:create_pedido]

    test "renders pedido when data is valid", %{conn: conn, pedido: %Pedido{id: id} = pedido} do
      conn = put(conn, ~p"/api/pedidos/#{pedido}", pedido: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/pedidos/#{id}")

      assert %{
               "id" => ^id,
               "activo" => false,
               "fecha_pedido" => "2025-10-26",
               "total" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pedido: pedido} do
      conn = put(conn, ~p"/api/pedidos/#{pedido}", pedido: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pedido" do
    setup [:create_pedido]

    test "deletes chosen pedido", %{conn: conn, pedido: pedido} do
      conn = delete(conn, ~p"/api/pedidos/#{pedido}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/pedidos/#{pedido}")
      end
    end
  end

  defp create_pedido(_) do
    pedido = pedido_fixture()

    %{pedido: pedido}
  end
end
