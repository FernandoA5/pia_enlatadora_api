defmodule EnlatadoraApiWeb.ProductoJSON do
  alias EnlatadoraApi.Productos.Producto

  @doc """
  Renders a list of productos.
  """
  def index(%{productos: productos}) do
    %{data: for(producto <- productos, do: data(producto))}
  end

  @doc """
  Renders a single producto.
  """
  def show(%{producto: producto}) do
    %{data: data(producto)}
  end

  defp data(%Producto{} = producto) do
    %{
      id: producto.id,
      nombre: producto.nombre,
      descripcion: producto.descripcion,
      unidad_medida: producto.unidad_medida,
      stock_actual: producto.stock_actual,
      activo: producto.activo
    }
  end
end
