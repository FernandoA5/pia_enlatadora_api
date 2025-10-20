defmodule EnlatadoraApiWeb.ProductoControllerTest do
  use EnlatadoraApiWeb.ConnCase

  import EnlatadoraApi.ProductosFixtures
  alias EnlatadoraApi.Productos.Producto

  @create_attrs %{
    nombre: "some nombre",
    descripcion: "some descripcion",
    unidad_medida: "some unidad_medida",
    stock_actual: "120.5",
    activo: true
  }
  @update_attrs %{
    nombre: "some updated nombre",
    descripcion: "some updated descripcion",
    unidad_medida: "some updated unidad_medida",
    stock_actual: "456.7",
    activo: false
  }
  @invalid_attrs %{nombre: nil, descripcion: nil, unidad_medida: nil, stock_actual: nil, activo: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all productos", %{conn: conn} do
      conn = get(conn, ~p"/api/productos")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create producto" do
    test "renders producto when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/productos", producto: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/productos/#{id}")

      assert %{
               "id" => ^id,
               "activo" => true,
               "descripcion" => "some descripcion",
               "nombre" => "some nombre",
               "stock_actual" => "120.5",
               "unidad_medida" => "some unidad_medida"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/productos", producto: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update producto" do
    setup [:create_producto]

    test "renders producto when data is valid", %{conn: conn, producto: %Producto{id: id} = producto} do
      conn = put(conn, ~p"/api/productos/#{producto}", producto: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/productos/#{id}")

      assert %{
               "id" => ^id,
               "activo" => false,
               "descripcion" => "some updated descripcion",
               "nombre" => "some updated nombre",
               "stock_actual" => "456.7",
               "unidad_medida" => "some updated unidad_medida"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, producto: producto} do
      conn = put(conn, ~p"/api/productos/#{producto}", producto: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete producto" do
    setup [:create_producto]

    test "deletes chosen producto", %{conn: conn, producto: producto} do
      conn = delete(conn, ~p"/api/productos/#{producto}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/productos/#{producto}")
      end
    end
  end

  defp create_producto(_) do
    producto = producto_fixture()

    %{producto: producto}
  end
end
