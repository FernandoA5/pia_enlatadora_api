defmodule EnlatadoraApi.PedidosTest do
  use EnlatadoraApi.DataCase

  alias EnlatadoraApi.Pedidos

  describe "pedidos" do
    alias EnlatadoraApi.Pedidos.Pedido

    import EnlatadoraApi.PedidosFixtures

    @invalid_attrs %{total: nil, fecha_pedido: nil, activo: nil}

    test "list_pedidos/0 returns all pedidos" do
      pedido = pedido_fixture()
      assert Pedidos.list_pedidos() == [pedido]
    end

    test "get_pedido!/1 returns the pedido with given id" do
      pedido = pedido_fixture()
      assert Pedidos.get_pedido!(pedido.id) == pedido
    end

    test "create_pedido/1 with valid data creates a pedido" do
      valid_attrs = %{total: "120.5", fecha_pedido: ~D[2025-10-25], activo: true}

      assert {:ok, %Pedido{} = pedido} = Pedidos.create_pedido(valid_attrs)
      assert pedido.total == Decimal.new("120.5")
      assert pedido.fecha_pedido == ~D[2025-10-25]
      assert pedido.activo == true
    end

    test "create_pedido/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pedidos.create_pedido(@invalid_attrs)
    end

    test "update_pedido/2 with valid data updates the pedido" do
      pedido = pedido_fixture()
      update_attrs = %{total: "456.7", fecha_pedido: ~D[2025-10-26], activo: false}

      assert {:ok, %Pedido{} = pedido} = Pedidos.update_pedido(pedido, update_attrs)
      assert pedido.total == Decimal.new("456.7")
      assert pedido.fecha_pedido == ~D[2025-10-26]
      assert pedido.activo == false
    end

    test "update_pedido/2 with invalid data returns error changeset" do
      pedido = pedido_fixture()
      assert {:error, %Ecto.Changeset{}} = Pedidos.update_pedido(pedido, @invalid_attrs)
      assert pedido == Pedidos.get_pedido!(pedido.id)
    end

    test "delete_pedido/1 deletes the pedido" do
      pedido = pedido_fixture()
      assert {:ok, %Pedido{}} = Pedidos.delete_pedido(pedido)
      assert_raise Ecto.NoResultsError, fn -> Pedidos.get_pedido!(pedido.id) end
    end

    test "change_pedido/1 returns a pedido changeset" do
      pedido = pedido_fixture()
      assert %Ecto.Changeset{} = Pedidos.change_pedido(pedido)
    end
  end
end
