defmodule EnlatadoraApiWeb.ControlCalidadControllerTest do
  use EnlatadoraApiWeb.ConnCase

  import EnlatadoraApi.ControlesCalidadFixtures
  alias EnlatadoraApi.ControlesCalidad.ControlCalidad

  @create_attrs %{
    fecha_control: ~D[2025-10-25],
    resultado: "some resultado",
    observaciones: "some observaciones",
    activo: true
  }
  @update_attrs %{
    fecha_control: ~D[2025-10-26],
    resultado: "some updated resultado",
    observaciones: "some updated observaciones",
    activo: false
  }
  @invalid_attrs %{fecha_control: nil, resultado: nil, observaciones: nil, activo: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all controles_calidad", %{conn: conn} do
      conn = get(conn, ~p"/api/controles_calidad")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create control_calidad" do
    test "renders control_calidad when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/controles_calidad", control_calidad: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/controles_calidad/#{id}")

      assert %{
               "id" => ^id,
               "activo" => true,
               "fecha_control" => "2025-10-25",
               "observaciones" => "some observaciones",
               "resultado" => "some resultado"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/controles_calidad", control_calidad: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update control_calidad" do
    setup [:create_control_calidad]

    test "renders control_calidad when data is valid", %{conn: conn, control_calidad: %ControlCalidad{id: id} = control_calidad} do
      conn = put(conn, ~p"/api/controles_calidad/#{control_calidad}", control_calidad: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/controles_calidad/#{id}")

      assert %{
               "id" => ^id,
               "activo" => false,
               "fecha_control" => "2025-10-26",
               "observaciones" => "some updated observaciones",
               "resultado" => "some updated resultado"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, control_calidad: control_calidad} do
      conn = put(conn, ~p"/api/controles_calidad/#{control_calidad}", control_calidad: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete control_calidad" do
    setup [:create_control_calidad]

    test "deletes chosen control_calidad", %{conn: conn, control_calidad: control_calidad} do
      conn = delete(conn, ~p"/api/controles_calidad/#{control_calidad}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/controles_calidad/#{control_calidad}")
      end
    end
  end

  defp create_control_calidad(_) do
    control_calidad = control_calidad_fixture()

    %{control_calidad: control_calidad}
  end
end
