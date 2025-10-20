defmodule EnlatadoraApi.MateriasPrimasTest do
  use EnlatadoraApi.DataCase

  alias EnlatadoraApi.MateriasPrimas

  describe "materias_primas" do
    alias EnlatadoraApi.MateriasPrimas.MateriaPrima

    import EnlatadoraApi.MateriasPrimasFixtures

    @invalid_attrs %{nombre: nil, descripcion: nil, unidad_medida: nil, stock_actual: nil, stock_minimo: nil}

    test "list_materias_primas/0 returns all materias_primas" do
      materia_prima = materia_prima_fixture()
      assert MateriasPrimas.list_materias_primas() == [materia_prima]
    end

    test "get_materia_prima!/1 returns the materia_prima with given id" do
      materia_prima = materia_prima_fixture()
      assert MateriasPrimas.get_materia_prima!(materia_prima.id) == materia_prima
    end

    test "create_materia_prima/1 with valid data creates a materia_prima" do
      valid_attrs = %{nombre: "some nombre", descripcion: "some descripcion", unidad_medida: "some unidad_medida", stock_actual: "120.5", stock_minimo: "120.5"}

      assert {:ok, %MateriaPrima{} = materia_prima} = MateriasPrimas.create_materia_prima(valid_attrs)
      assert materia_prima.nombre == "some nombre"
      assert materia_prima.descripcion == "some descripcion"
      assert materia_prima.unidad_medida == "some unidad_medida"
      assert materia_prima.stock_actual == Decimal.new("120.5")
      assert materia_prima.stock_minimo == Decimal.new("120.5")
    end

    test "create_materia_prima/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MateriasPrimas.create_materia_prima(@invalid_attrs)
    end

    test "update_materia_prima/2 with valid data updates the materia_prima" do
      materia_prima = materia_prima_fixture()
      update_attrs = %{nombre: "some updated nombre", descripcion: "some updated descripcion", unidad_medida: "some updated unidad_medida", stock_actual: "456.7", stock_minimo: "456.7"}

      assert {:ok, %MateriaPrima{} = materia_prima} = MateriasPrimas.update_materia_prima(materia_prima, update_attrs)
      assert materia_prima.nombre == "some updated nombre"
      assert materia_prima.descripcion == "some updated descripcion"
      assert materia_prima.unidad_medida == "some updated unidad_medida"
      assert materia_prima.stock_actual == Decimal.new("456.7")
      assert materia_prima.stock_minimo == Decimal.new("456.7")
    end

    test "update_materia_prima/2 with invalid data returns error changeset" do
      materia_prima = materia_prima_fixture()
      assert {:error, %Ecto.Changeset{}} = MateriasPrimas.update_materia_prima(materia_prima, @invalid_attrs)
      assert materia_prima == MateriasPrimas.get_materia_prima!(materia_prima.id)
    end

    test "delete_materia_prima/1 deletes the materia_prima" do
      materia_prima = materia_prima_fixture()
      assert {:ok, %MateriaPrima{}} = MateriasPrimas.delete_materia_prima(materia_prima)
      assert_raise Ecto.NoResultsError, fn -> MateriasPrimas.get_materia_prima!(materia_prima.id) end
    end

    test "change_materia_prima/1 returns a materia_prima changeset" do
      materia_prima = materia_prima_fixture()
      assert %Ecto.Changeset{} = MateriasPrimas.change_materia_prima(materia_prima)
    end
  end
end
