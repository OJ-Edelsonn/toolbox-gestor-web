# Instrucciones para ejecutar la base de datos

Estas instrucciones son para que ejecutes el script desde MySQL Workbench usando MySQL de XAMPP.

## 1. Iniciar MySQL

1. Abre XAMPP Control Panel.
2. Presiona `Start` en MySQL.
3. Verifica que MySQL quede activo en el puerto `3306`.

## 2. Abrir MySQL Workbench

1. Abre MySQL Workbench.
2. Entra a tu conexion local.
3. Usa estos datos si Workbench los solicita:

```text
Host: localhost
Puerto: 3306
Usuario: root
Contrasena: vacia
```

## 3. Ejecutar el script

1. En MySQL Workbench, ve a `File > Open SQL Script`.
2. Selecciona este archivo:

```text
C:\Users\EDELSON ORIHUELA\OneDrive\Documentos\toolbox-gestor-web\database\bd_toolbox_gestor_web.sql
```

3. Presiona el boton del rayo para ejecutar todo el script.
4. Si aparece una advertencia por `DROP DATABASE`, acepta continuar.

## 4. Verificar la base de datos

Ejecuta estas consultas:

```sql
USE bd_toolbox_gestor_web;

SELECT COUNT(*) AS total_categorias FROM categoria;
SELECT COUNT(*) AS total_proveedores FROM proveedor;
SELECT COUNT(*) AS total_clientes FROM cliente;
SELECT COUNT(*) AS total_productos FROM producto;
SELECT COUNT(*) AS total_ventas FROM venta;
SELECT COUNT(*) AS total_detalles FROM detalle_venta;

SELECT
    p.codigo_producto,
    p.nombre_producto,
    c.nombre AS categoria,
    p.stock,
    p.stock_minimo
FROM producto p
INNER JOIN categoria c ON c.id_categoria = p.id_categoria
WHERE p.stock <= p.stock_minimo;
```

Resultados esperados:

- 8 categorias.
- 6 proveedores.
- 15 clientes.
- 30 productos.
- 5 ventas.
- 13 detalles de venta.
- Algunos productos con bajo stock, por ejemplo `Serrucho`, `Tablero electrico`, `Casco de seguridad` y `Carretilla`.
