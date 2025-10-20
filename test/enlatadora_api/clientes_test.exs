defmodule EnlatadoraApi.ClientesTest do
  use EnlatadoraApi.DataCase

  alias EnlatadoraApi.Clientes

  describe "clientes" do
    alias EnlatadoraApi.Clientes.Cliente

    import EnlatadoraApi.ClientesFixtures

    @invalid_attrs %{nombre: nil, telefono: nil, direccion: nil, correo: nil, activo: nil}

    test "list_clientes/0 returns all clientes" do
      cliente = cliente_fixture()
      assert Clientes.list_clientes() == [cliente]
    end

    test "get_cliente!/1 returns the cliente with given id" do
      cliente = cliente_fixture()
      assert Clientes.get_cliente!(cliente.id) == cliente
    end

    test "create_cliente/1 with valid data creates a cliente" do
      valid_attrs = %{nombre: "some nombre", telefono: "some telefono", direccion: "some direccion", correo: "some correo", activo: true}

      assert {:ok, %Cliente{} = cliente} = Clientes.create_cliente(valid_attrs)
      assert cliente.nombre == "some nombre"
      assert cliente.telefono == "some telefono"
      assert cliente.direccion == "some direccion"
      assert cliente.correo == "some correo"
      assert cliente.activo == true
    end

    test "create_cliente/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clientes.create_cliente(@invalid_attrs)
    end

    test "update_cliente/2 with valid data updates the cliente" do
      cliente = cliente_fixture()
      update_attrs = %{nombre: "some updated nombre", telefono: "some updated telefono", direccion: "some updated direccion", correo: "some updated correo", activo: false}

      assert {:ok, %Cliente{} = cliente} = Clientes.update_cliente(cliente, update_attrs)
      assert cliente.nombre == "some updated nombre"
      assert cliente.telefono == "some updated telefono"
      assert cliente.direccion == "some updated direccion"
      assert cliente.correo == "some updated correo"
      assert cliente.activo == false
    end

    test "update_cliente/2 with invalid data returns error changeset" do
      cliente = cliente_fixture()
      assert {:error, %Ecto.Changeset{}} = Clientes.update_cliente(cliente, @invalid_attrs)
      assert cliente == Clientes.get_cliente!(cliente.id)
    end

    test "delete_cliente/1 deletes the cliente" do
      cliente = cliente_fixture()
      assert {:ok, %Cliente{}} = Clientes.delete_cliente(cliente)
      assert_raise Ecto.NoResultsError, fn -> Clientes.get_cliente!(cliente.id) end
    end

    test "change_cliente/1 returns a cliente changeset" do
      cliente = cliente_fixture()
      assert %Ecto.Changeset{} = Clientes.change_cliente(cliente)
    end
  end
end
