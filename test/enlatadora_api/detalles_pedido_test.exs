defmodule EnlatadoraApi.DetallesPedidoTest do
  use EnlatadoraApi.DataCase

  alias EnlatadoraApi.DetallesPedido

  describe "detalles_pedido" do
    alias EnlatadoraApi.DetallesPedido.DetallePedido

    import EnlatadoraApi.DetallesPedidoFixtures

    @invalid_attrs %{cantidad: nil, precio_unitario: nil, activo: nil}

    test "list_detalles_pedido/0 returns all detalles_pedido" do
      detalle_pedido = detalle_pedido_fixture()
      assert DetallesPedido.list_detalles_pedido() == [detalle_pedido]
    end

    test "get_detalle_pedido!/1 returns the detalle_pedido with given id" do
      detalle_pedido = detalle_pedido_fixture()
      assert DetallesPedido.get_detalle_pedido!(detalle_pedido.id) == detalle_pedido
    end

    test "create_detalle_pedido/1 with valid data creates a detalle_pedido" do
      valid_attrs = %{cantidad: "120.5", precio_unitario: "120.5", activo: true}

      assert {:ok, %DetallePedido{} = detalle_pedido} = DetallesPedido.create_detalle_pedido(valid_attrs)
      assert detalle_pedido.cantidad == Decimal.new("120.5")
      assert detalle_pedido.precio_unitario == Decimal.new("120.5")
      assert detalle_pedido.activo == true
    end

    test "create_detalle_pedido/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DetallesPedido.create_detalle_pedido(@invalid_attrs)
    end

    test "update_detalle_pedido/2 with valid data updates the detalle_pedido" do
      detalle_pedido = detalle_pedido_fixture()
      update_attrs = %{cantidad: "456.7", precio_unitario: "456.7", activo: false}

      assert {:ok, %DetallePedido{} = detalle_pedido} = DetallesPedido.update_detalle_pedido(detalle_pedido, update_attrs)
      assert detalle_pedido.cantidad == Decimal.new("456.7")
      assert detalle_pedido.precio_unitario == Decimal.new("456.7")
      assert detalle_pedido.activo == false
    end

    test "update_detalle_pedido/2 with invalid data returns error changeset" do
      detalle_pedido = detalle_pedido_fixture()
      assert {:error, %Ecto.Changeset{}} = DetallesPedido.update_detalle_pedido(detalle_pedido, @invalid_attrs)
      assert detalle_pedido == DetallesPedido.get_detalle_pedido!(detalle_pedido.id)
    end

    test "delete_detalle_pedido/1 deletes the detalle_pedido" do
      detalle_pedido = detalle_pedido_fixture()
      assert {:ok, %DetallePedido{}} = DetallesPedido.delete_detalle_pedido(detalle_pedido)
      assert_raise Ecto.NoResultsError, fn -> DetallesPedido.get_detalle_pedido!(detalle_pedido.id) end
    end

    test "change_detalle_pedido/1 returns a detalle_pedido changeset" do
      detalle_pedido = detalle_pedido_fixture()
      assert %Ecto.Changeset{} = DetallesPedido.change_detalle_pedido(detalle_pedido)
    end
  end
end
