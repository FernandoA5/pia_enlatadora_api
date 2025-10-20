defmodule EnlatadoraApi.ProveedoresTest do
  use EnlatadoraApi.DataCase

  alias EnlatadoraApi.Proveedores

  describe "proveedores" do
    alias EnlatadoraApi.Proveedores.Proveedor

    import EnlatadoraApi.ProveedoresFixtures

    @invalid_attrs %{nombre: nil, telefono: nil, direccion: nil, correo: nil, activo: nil}

    test "list_proveedores/0 returns all proveedores" do
      proveedor = proveedor_fixture()
      assert Proveedores.list_proveedores() == [proveedor]
    end

    test "get_proveedor!/1 returns the proveedor with given id" do
      proveedor = proveedor_fixture()
      assert Proveedores.get_proveedor!(proveedor.id) == proveedor
    end

    test "create_proveedor/1 with valid data creates a proveedor" do
      valid_attrs = %{nombre: "some nombre", telefono: "some telefono", direccion: "some direccion", correo: "some correo", activo: true}

      assert {:ok, %Proveedor{} = proveedor} = Proveedores.create_proveedor(valid_attrs)
      assert proveedor.nombre == "some nombre"
      assert proveedor.telefono == "some telefono"
      assert proveedor.direccion == "some direccion"
      assert proveedor.correo == "some correo"
      assert proveedor.activo == true
    end

    test "create_proveedor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Proveedores.create_proveedor(@invalid_attrs)
    end

    test "update_proveedor/2 with valid data updates the proveedor" do
      proveedor = proveedor_fixture()
      update_attrs = %{nombre: "some updated nombre", telefono: "some updated telefono", direccion: "some updated direccion", correo: "some updated correo", activo: false}

      assert {:ok, %Proveedor{} = proveedor} = Proveedores.update_proveedor(proveedor, update_attrs)
      assert proveedor.nombre == "some updated nombre"
      assert proveedor.telefono == "some updated telefono"
      assert proveedor.direccion == "some updated direccion"
      assert proveedor.correo == "some updated correo"
      assert proveedor.activo == false
    end

    test "update_proveedor/2 with invalid data returns error changeset" do
      proveedor = proveedor_fixture()
      assert {:error, %Ecto.Changeset{}} = Proveedores.update_proveedor(proveedor, @invalid_attrs)
      assert proveedor == Proveedores.get_proveedor!(proveedor.id)
    end

    test "delete_proveedor/1 deletes the proveedor" do
      proveedor = proveedor_fixture()
      assert {:ok, %Proveedor{}} = Proveedores.delete_proveedor(proveedor)
      assert_raise Ecto.NoResultsError, fn -> Proveedores.get_proveedor!(proveedor.id) end
    end

    test "change_proveedor/1 returns a proveedor changeset" do
      proveedor = proveedor_fixture()
      assert %Ecto.Changeset{} = Proveedores.change_proveedor(proveedor)
    end
  end
end
