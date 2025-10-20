defmodule EnlatadoraApiWeb.ProveedorControllerTest do
  use EnlatadoraApiWeb.ConnCase

  import EnlatadoraApi.ProveedoresFixtures
  alias EnlatadoraApi.Proveedores.Proveedor

  @create_attrs %{
    nombre: "some nombre",
    telefono: "some telefono",
    direccion: "some direccion",
    correo: "some correo",
    activo: true
  }
  @update_attrs %{
    nombre: "some updated nombre",
    telefono: "some updated telefono",
    direccion: "some updated direccion",
    correo: "some updated correo",
    activo: false
  }
  @invalid_attrs %{nombre: nil, telefono: nil, direccion: nil, correo: nil, activo: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all proveedores", %{conn: conn} do
      conn = get(conn, ~p"/api/proveedores")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create proveedor" do
    test "renders proveedor when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/proveedores", proveedor: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/proveedores/#{id}")

      assert %{
               "id" => ^id,
               "activo" => true,
               "correo" => "some correo",
               "direccion" => "some direccion",
               "nombre" => "some nombre",
               "telefono" => "some telefono"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/proveedores", proveedor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update proveedor" do
    setup [:create_proveedor]

    test "renders proveedor when data is valid", %{conn: conn, proveedor: %Proveedor{id: id} = proveedor} do
      conn = put(conn, ~p"/api/proveedores/#{proveedor}", proveedor: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/proveedores/#{id}")

      assert %{
               "id" => ^id,
               "activo" => false,
               "correo" => "some updated correo",
               "direccion" => "some updated direccion",
               "nombre" => "some updated nombre",
               "telefono" => "some updated telefono"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, proveedor: proveedor} do
      conn = put(conn, ~p"/api/proveedores/#{proveedor}", proveedor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete proveedor" do
    setup [:create_proveedor]

    test "deletes chosen proveedor", %{conn: conn, proveedor: proveedor} do
      conn = delete(conn, ~p"/api/proveedores/#{proveedor}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/proveedores/#{proveedor}")
      end
    end
  end

  defp create_proveedor(_) do
    proveedor = proveedor_fixture()

    %{proveedor: proveedor}
  end
end
