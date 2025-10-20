defmodule EnlatadoraApi.ComprasTest do
  use EnlatadoraApi.DataCase

  alias EnlatadoraApi.Compras

  describe "compras_materia_prima" do
    alias EnlatadoraApi.Compras.CompraMateriaPrima

    import EnlatadoraApi.ComprasFixtures

    @invalid_attrs %{total: nil, fecha_compra: nil, activo: nil}

    test "list_compras_materia_prima/0 returns all compras_materia_prima" do
      compra_materia_prima = compra_materia_prima_fixture()
      assert Compras.list_compras_materia_prima() == [compra_materia_prima]
    end

    test "get_compra_materia_prima!/1 returns the compra_materia_prima with given id" do
      compra_materia_prima = compra_materia_prima_fixture()
      assert Compras.get_compra_materia_prima!(compra_materia_prima.id) == compra_materia_prima
    end

    test "create_compra_materia_prima/1 with valid data creates a compra_materia_prima" do
      valid_attrs = %{total: "120.5", fecha_compra: ~D[2025-10-19], activo: true}

      assert {:ok, %CompraMateriaPrima{} = compra_materia_prima} = Compras.create_compra_materia_prima(valid_attrs)
      assert compra_materia_prima.total == Decimal.new("120.5")
      assert compra_materia_prima.fecha_compra == ~D[2025-10-19]
      assert compra_materia_prima.activo == true
    end

    test "create_compra_materia_prima/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Compras.create_compra_materia_prima(@invalid_attrs)
    end

    test "update_compra_materia_prima/2 with valid data updates the compra_materia_prima" do
      compra_materia_prima = compra_materia_prima_fixture()
      update_attrs = %{total: "456.7", fecha_compra: ~D[2025-10-20], activo: false}

      assert {:ok, %CompraMateriaPrima{} = compra_materia_prima} = Compras.update_compra_materia_prima(compra_materia_prima, update_attrs)
      assert compra_materia_prima.total == Decimal.new("456.7")
      assert compra_materia_prima.fecha_compra == ~D[2025-10-20]
      assert compra_materia_prima.activo == false
    end

    test "update_compra_materia_prima/2 with invalid data returns error changeset" do
      compra_materia_prima = compra_materia_prima_fixture()
      assert {:error, %Ecto.Changeset{}} = Compras.update_compra_materia_prima(compra_materia_prima, @invalid_attrs)
      assert compra_materia_prima == Compras.get_compra_materia_prima!(compra_materia_prima.id)
    end

    test "delete_compra_materia_prima/1 deletes the compra_materia_prima" do
      compra_materia_prima = compra_materia_prima_fixture()
      assert {:ok, %CompraMateriaPrima{}} = Compras.delete_compra_materia_prima(compra_materia_prima)
      assert_raise Ecto.NoResultsError, fn -> Compras.get_compra_materia_prima!(compra_materia_prima.id) end
    end

    test "change_compra_materia_prima/1 returns a compra_materia_prima changeset" do
      compra_materia_prima = compra_materia_prima_fixture()
      assert %Ecto.Changeset{} = Compras.change_compra_materia_prima(compra_materia_prima)
    end
  end
end
