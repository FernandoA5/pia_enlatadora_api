defmodule EnlatadoraApi.ProduccionesTest do
  use EnlatadoraApi.DataCase

  alias EnlatadoraApi.Producciones

  describe "producciones" do
    alias EnlatadoraApi.Producciones.Produccion

    import EnlatadoraApi.ProduccionesFixtures

    @invalid_attrs %{fecha_produccion: nil, cantidad_producida: nil, estado: nil, activo: nil}

    test "list_producciones/0 returns all producciones" do
      produccion = produccion_fixture()
      assert Producciones.list_producciones() == [produccion]
    end

    test "get_produccion!/1 returns the produccion with given id" do
      produccion = produccion_fixture()
      assert Producciones.get_produccion!(produccion.id) == produccion
    end

    test "create_produccion/1 with valid data creates a produccion" do
      valid_attrs = %{fecha_produccion: ~D[2025-10-24], cantidad_producida: "120.5", estado: "some estado", activo: true}

      assert {:ok, %Produccion{} = produccion} = Producciones.create_produccion(valid_attrs)
      assert produccion.fecha_produccion == ~D[2025-10-24]
      assert produccion.cantidad_producida == Decimal.new("120.5")
      assert produccion.estado == "some estado"
      assert produccion.activo == true
    end

    test "create_produccion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Producciones.create_produccion(@invalid_attrs)
    end

    test "update_produccion/2 with valid data updates the produccion" do
      produccion = produccion_fixture()
      update_attrs = %{fecha_produccion: ~D[2025-10-25], cantidad_producida: "456.7", estado: "some updated estado", activo: false}

      assert {:ok, %Produccion{} = produccion} = Producciones.update_produccion(produccion, update_attrs)
      assert produccion.fecha_produccion == ~D[2025-10-25]
      assert produccion.cantidad_producida == Decimal.new("456.7")
      assert produccion.estado == "some updated estado"
      assert produccion.activo == false
    end

    test "update_produccion/2 with invalid data returns error changeset" do
      produccion = produccion_fixture()
      assert {:error, %Ecto.Changeset{}} = Producciones.update_produccion(produccion, @invalid_attrs)
      assert produccion == Producciones.get_produccion!(produccion.id)
    end

    test "delete_produccion/1 deletes the produccion" do
      produccion = produccion_fixture()
      assert {:ok, %Produccion{}} = Producciones.delete_produccion(produccion)
      assert_raise Ecto.NoResultsError, fn -> Producciones.get_produccion!(produccion.id) end
    end

    test "change_produccion/1 returns a produccion changeset" do
      produccion = produccion_fixture()
      assert %Ecto.Changeset{} = Producciones.change_produccion(produccion)
    end
  end
end
