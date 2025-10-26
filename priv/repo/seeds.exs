# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EnlatadoraApi.Repo.insert!(%EnlatadoraApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias EnlatadoraApi.Repo
alias EnlatadoraApi.MateriasPrimas.MateriaPrima
alias EnlatadoraApi.Proveedores.Proveedor
alias EnlatadoraApi.Clientes.Cliente
alias EnlatadoraApi.Productos.Producto

IO.puts("Limpiando datos existentes...")

# Limpiar datos existentes (en orden inverso por dependencias)
Repo.delete_all(Producto)
Repo.delete_all(Cliente)
Repo.delete_all(Proveedor)
Repo.delete_all(MateriaPrima)

IO.puts("Poblando catálogos...")

# ==========================================
# Catálogo: Materias Primas
# ==========================================
IO.puts("  → Insertando materias primas...")

materias_primas = [
  %{
    nombre: "Tomate Rojo",
    descripcion: "Tomate rojo fresco de primera calidad para procesamiento",
    unidad_medida: "Kg",
    stock_actual: Decimal.new("1500.00"),
    stock_minimo: Decimal.new("200.00"),
    activo: true
  },
  %{
    nombre: "Jalapeño",
    descripcion: "Chile jalapeño verde fresco para enlatado",
    unidad_medida: "Kg",
    stock_actual: Decimal.new("800.00"),
    stock_minimo: Decimal.new("150.00"),
    activo: true
  },
  %{
    nombre: "Maíz Amarillo",
    descripcion: "Maíz amarillo grano entero para conserva",
    unidad_medida: "Kg",
    stock_actual: Decimal.new("2000.00"),
    stock_minimo: Decimal.new("300.00"),
    activo: true
  },
  %{
    nombre: "Frijol Negro",
    descripcion: "Frijol negro de primera calidad para enlatado",
    unidad_medida: "Kg",
    stock_actual: Decimal.new("1200.00"),
    stock_minimo: Decimal.new("250.00"),
    activo: true
  },
  %{
    nombre: "Chile Chipotle",
    descripcion: "Chile chipotle ahumado para procesamiento",
    unidad_medida: "Kg",
    stock_actual: Decimal.new("500.00"),
    stock_minimo: Decimal.new("100.00"),
    activo: true
  }
]

Enum.each(materias_primas, fn materia ->
  Repo.insert!(%MateriaPrima{
    nombre: materia.nombre,
    descripcion: materia.descripcion,
    unidad_medida: materia.unidad_medida,
    stock_actual: materia.stock_actual,
    stock_minimo: materia.stock_minimo,
    activo: materia.activo
  })
end)

IO.puts("    ✓ #{length(materias_primas)} materias primas insertadas")

# ==========================================
# Catálogo: Proveedores
# ==========================================
IO.puts("  → Insertando proveedores...")

proveedores = [
  %{
    nombre: "Agrícola San Miguel S.A. de C.V.",
    telefono: "+52 (33) 3614-8520",
    direccion: "Av. Revolución 2450, Guadalajara, Jalisco",
    correo: "ventas@agricolasanmiguel.com.mx",
    activo: true
  },
  %{
    nombre: "Distribuidora de Chiles La Costeña",
    telefono: "+52 (55) 5729-0300",
    direccion: "Calzada de Tlalpan 1234, Ciudad de México",
    correo: "contacto@chileslacoste.mx",
    activo: true
  },
  %{
    nombre: "Granos y Leguminosas del Bajío",
    telefono: "+52 (461) 612-3456",
    direccion: "Carretera Celaya-Querétaro Km 12, Celaya, Guanajuato",
    correo: "ventas@granosbajio.com",
    activo: true
  },
  %{
    nombre: "Hortalizas Frescas del Norte",
    telefono: "+52 (81) 8356-9870",
    direccion: "Parque Industrial Apodaca, Monterrey, Nuevo León",
    correo: "compras@hortalizasdelnorte.mx",
    activo: true
  },
  %{
    nombre: "Productos Agrícolas La Huerta",
    telefono: "+52 (222) 248-1590",
    direccion: "Boulevard Atlixco 5678, Puebla, Puebla",
    correo: "info@lahuertapuebla.com.mx",
    activo: true
  }
]

Enum.each(proveedores, fn proveedor ->
  Repo.insert!(%Proveedor{
    nombre: proveedor.nombre,
    telefono: proveedor.telefono,
    direccion: proveedor.direccion,
    correo: proveedor.correo,
    activo: proveedor.activo
  })
end)

IO.puts("    ✓ #{length(proveedores)} proveedores insertados")

# ==========================================
# Catálogo: Clientes
# ==========================================
IO.puts("  → Insertando clientes...")

clientes = [
  %{
    nombre: "Soriana S.A. de C.V.",
    telefono: "+52 (81) 8152-5000",
    direccion: "Av. Lázaro Cárdenas 2400, Monterrey, Nuevo León",
    correo: "proveedores@soriana.com",
    activo: true
  },
  %{
    nombre: "Chedraui Comercial Mexicana",
    telefono: "+52 (55) 5268-9000",
    direccion: "Paseo de la Reforma 250, Ciudad de México",
    correo: "compras@chedraui.com.mx",
    activo: true
  },
  %{
    nombre: "Walmart de México y Centroamérica",
    telefono: "+52 (55) 5283-0100",
    direccion: "Nextengo 78, Ciudad de México",
    correo: "proveedores@walmart.com.mx",
    activo: true
  },
  %{
    nombre: "HEB México",
    telefono: "+52 (81) 8389-6900",
    direccion: "Av. San Jerónimo 800, Monterrey, Nuevo León",
    correo: "ventas@heb.com.mx",
    activo: true
  },
  %{
    nombre: "Distribuidora Comercial del Pacífico",
    telefono: "+52 (33) 3647-2100",
    direccion: "Av. Américas 1500, Guadalajara, Jalisco",
    correo: "contacto@dicopacifico.mx",
    activo: true
  }
]

Enum.each(clientes, fn cliente ->
  Repo.insert!(%Cliente{
    nombre: cliente.nombre,
    telefono: cliente.telefono,
    direccion: cliente.direccion,
    correo: cliente.correo,
    activo: cliente.activo
  })
end)

IO.puts("    ✓ #{length(clientes)} clientes insertados")

# ==========================================
# Catálogo: Productos
# ==========================================
IO.puts("  → Insertando productos...")

productos = [
  %{
    nombre: "Tomate Enlatado La Enlatadora 500g",
    descripcion: "Tomate rojo pelado entero en su jugo, presentación 500g",
    unidad_medida: "Lata",
    stock_actual: Decimal.new("5000.00"),
    activo: true
  },
  %{
    nombre: "Jalapeños en Escabeche La Enlatadora 350g",
    descripcion: "Chiles jalapeños en rodajas con zanahoria y cebolla en escabeche",
    unidad_medida: "Lata",
    stock_actual: Decimal.new("3500.00"),
    activo: true
  },
  %{
    nombre: "Maíz Dulce en Grano La Enlatadora 410g",
    descripcion: "Granos de maíz dulce amarillo en agua y sal",
    unidad_medida: "Lata",
    stock_actual: Decimal.new("4200.00"),
    activo: true
  },
  %{
    nombre: "Frijoles Negros Refritos La Enlatadora 430g",
    descripcion: "Frijoles negros refritos con especias tradicionales mexicanas",
    unidad_medida: "Lata",
    stock_actual: Decimal.new("6000.00"),
    activo: true
  },
  %{
    nombre: "Chiles Chipotles Adobados La Enlatadora 215g",
    descripcion: "Chiles chipotles enteros en salsa de adobo picante",
    unidad_medida: "Lata",
    stock_actual: Decimal.new("2800.00"),
    activo: true
  }
]

Enum.each(productos, fn producto ->
  Repo.insert!(%Producto{
    nombre: producto.nombre,
    descripcion: producto.descripcion,
    unidad_medida: producto.unidad_medida,
    stock_actual: producto.stock_actual,
    activo: producto.activo
  })
end)

IO.puts("    ✓ #{length(productos)} productos insertados")

IO.puts("\n✅ Seeds completados exitosamente!")
IO.puts("   Total de registros:")
IO.puts("   - Materias Primas: #{length(materias_primas)}")
IO.puts("   - Proveedores: #{length(proveedores)}")
IO.puts("   - Clientes: #{length(clientes)}")
IO.puts("   - Productos: #{length(productos)}")
