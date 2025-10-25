defmodule EnlatadoraApi.DetalleComprasTest do
  use EnlatadoraApi.DataCase

  alias EnlatadoraApi.DetalleCompras

  describe "detalle_compras" do
    alias EnlatadoraApi.DetalleCompras.DetalleCompra

    import EnlatadoraApi.DetalleComprasFixtures

    @invalid_attrs %{cantidad: nil, precio_unitario: nil}

    test "list_detalle_compras/0 returns all detalle_compras" do
      detalle_compra = detalle_compra_fixture()
      assert DetalleCompras.list_detalle_compras() == [detalle_compra]
    end

    test "get_detalle_compra!/1 returns the detalle_compra with given id" do
      detalle_compra = detalle_compra_fixture()
      assert DetalleCompras.get_detalle_compra!(detalle_compra.id) == detalle_compra
    end

    test "create_detalle_compra/1 with valid data creates a detalle_compra" do
      valid_attrs = %{cantidad: "120.5", precio_unitario: "120.5"}

      assert {:ok, %DetalleCompra{} = detalle_compra} = DetalleCompras.create_detalle_compra(valid_attrs)
      assert detalle_compra.cantidad == Decimal.new("120.5")
      assert detalle_compra.precio_unitario == Decimal.new("120.5")
    end

    test "create_detalle_compra/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DetalleCompras.create_detalle_compra(@invalid_attrs)
    end

    test "update_detalle_compra/2 with valid data updates the detalle_compra" do
      detalle_compra = detalle_compra_fixture()
      update_attrs = %{cantidad: "456.7", precio_unitario: "456.7"}

      assert {:ok, %DetalleCompra{} = detalle_compra} = DetalleCompras.update_detalle_compra(detalle_compra, update_attrs)
      assert detalle_compra.cantidad == Decimal.new("456.7")
      assert detalle_compra.precio_unitario == Decimal.new("456.7")
    end

    test "update_detalle_compra/2 with invalid data returns error changeset" do
      detalle_compra = detalle_compra_fixture()
      assert {:error, %Ecto.Changeset{}} = DetalleCompras.update_detalle_compra(detalle_compra, @invalid_attrs)
      assert detalle_compra == DetalleCompras.get_detalle_compra!(detalle_compra.id)
    end

    test "delete_detalle_compra/1 deletes the detalle_compra" do
      detalle_compra = detalle_compra_fixture()
      assert {:ok, %DetalleCompra{}} = DetalleCompras.delete_detalle_compra(detalle_compra)
      assert_raise Ecto.NoResultsError, fn -> DetalleCompras.get_detalle_compra!(detalle_compra.id) end
    end

    test "change_detalle_compra/1 returns a detalle_compra changeset" do
      detalle_compra = detalle_compra_fixture()
      assert %Ecto.Changeset{} = DetalleCompras.change_detalle_compra(detalle_compra)
    end
  end
end
