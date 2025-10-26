defmodule EnlatadoraApi.ControlesCalidadTest do
  use EnlatadoraApi.DataCase

  alias EnlatadoraApi.ControlesCalidad

  describe "controles_calidad" do
    alias EnlatadoraApi.ControlesCalidad.ControlCalidad

    import EnlatadoraApi.ControlesCalidadFixtures

    @invalid_attrs %{fecha_control: nil, resultado: nil, observaciones: nil, activo: nil}

    test "list_controles_calidad/0 returns all controles_calidad" do
      control_calidad = control_calidad_fixture()
      assert ControlesCalidad.list_controles_calidad() == [control_calidad]
    end

    test "get_control_calidad!/1 returns the control_calidad with given id" do
      control_calidad = control_calidad_fixture()
      assert ControlesCalidad.get_control_calidad!(control_calidad.id) == control_calidad
    end

    test "create_control_calidad/1 with valid data creates a control_calidad" do
      valid_attrs = %{fecha_control: ~D[2025-10-25], resultado: "some resultado", observaciones: "some observaciones", activo: true}

      assert {:ok, %ControlCalidad{} = control_calidad} = ControlesCalidad.create_control_calidad(valid_attrs)
      assert control_calidad.fecha_control == ~D[2025-10-25]
      assert control_calidad.resultado == "some resultado"
      assert control_calidad.observaciones == "some observaciones"
      assert control_calidad.activo == true
    end

    test "create_control_calidad/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ControlesCalidad.create_control_calidad(@invalid_attrs)
    end

    test "update_control_calidad/2 with valid data updates the control_calidad" do
      control_calidad = control_calidad_fixture()
      update_attrs = %{fecha_control: ~D[2025-10-26], resultado: "some updated resultado", observaciones: "some updated observaciones", activo: false}

      assert {:ok, %ControlCalidad{} = control_calidad} = ControlesCalidad.update_control_calidad(control_calidad, update_attrs)
      assert control_calidad.fecha_control == ~D[2025-10-26]
      assert control_calidad.resultado == "some updated resultado"
      assert control_calidad.observaciones == "some updated observaciones"
      assert control_calidad.activo == false
    end

    test "update_control_calidad/2 with invalid data returns error changeset" do
      control_calidad = control_calidad_fixture()
      assert {:error, %Ecto.Changeset{}} = ControlesCalidad.update_control_calidad(control_calidad, @invalid_attrs)
      assert control_calidad == ControlesCalidad.get_control_calidad!(control_calidad.id)
    end

    test "delete_control_calidad/1 deletes the control_calidad" do
      control_calidad = control_calidad_fixture()
      assert {:ok, %ControlCalidad{}} = ControlesCalidad.delete_control_calidad(control_calidad)
      assert_raise Ecto.NoResultsError, fn -> ControlesCalidad.get_control_calidad!(control_calidad.id) end
    end

    test "change_control_calidad/1 returns a control_calidad changeset" do
      control_calidad = control_calidad_fixture()
      assert %Ecto.Changeset{} = ControlesCalidad.change_control_calidad(control_calidad)
    end
  end
end
