defmodule EnlatadoraApi.ProductosTest do
  use EnlatadoraApi.DataCase

  alias EnlatadoraApi.Productos

  describe "productos" do
    alias EnlatadoraApi.Productos.Producto

    import EnlatadoraApi.ProductosFixtures

    @invalid_attrs %{nombre: nil, descripcion: nil, unidad_medida: nil, stock_actual: nil, activo: nil}

    test "list_productos/0 returns all productos" do
      producto = producto_fixture()
      assert Productos.list_productos() == [producto]
    end

    test "get_producto!/1 returns the producto with given id" do
      producto = producto_fixture()
      assert Productos.get_producto!(producto.id) == producto
    end

    test "create_producto/1 with valid data creates a producto" do
      valid_attrs = %{nombre: "some nombre", descripcion: "some descripcion", unidad_medida: "some unidad_medida", stock_actual: "120.5", activo: true}

      assert {:ok, %Producto{} = producto} = Productos.create_producto(valid_attrs)
      assert producto.nombre == "some nombre"
      assert producto.descripcion == "some descripcion"
      assert producto.unidad_medida == "some unidad_medida"
      assert producto.stock_actual == Decimal.new("120.5")
      assert producto.activo == true
    end

    test "create_producto/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Productos.create_producto(@invalid_attrs)
    end

    test "update_producto/2 with valid data updates the producto" do
      producto = producto_fixture()
      update_attrs = %{nombre: "some updated nombre", descripcion: "some updated descripcion", unidad_medida: "some updated unidad_medida", stock_actual: "456.7", activo: false}

      assert {:ok, %Producto{} = producto} = Productos.update_producto(producto, update_attrs)
      assert producto.nombre == "some updated nombre"
      assert producto.descripcion == "some updated descripcion"
      assert producto.unidad_medida == "some updated unidad_medida"
      assert producto.stock_actual == Decimal.new("456.7")
      assert producto.activo == false
    end

    test "update_producto/2 with invalid data returns error changeset" do
      producto = producto_fixture()
      assert {:error, %Ecto.Changeset{}} = Productos.update_producto(producto, @invalid_attrs)
      assert producto == Productos.get_producto!(producto.id)
    end

    test "delete_producto/1 deletes the producto" do
      producto = producto_fixture()
      assert {:ok, %Producto{}} = Productos.delete_producto(producto)
      assert_raise Ecto.NoResultsError, fn -> Productos.get_producto!(producto.id) end
    end

    test "change_producto/1 returns a producto changeset" do
      producto = producto_fixture()
      assert %Ecto.Changeset{} = Productos.change_producto(producto)
    end
  end
end
