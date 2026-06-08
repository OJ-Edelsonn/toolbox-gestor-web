# Explicacion MVC

## Proposito

Este documento servira como apoyo para la exposicion del proyecto ToolBox Gestor Web. Su objetivo es explicar como se aplica la arquitectura MVC en una aplicacion Java Web clasica con JSP, Servlets, JDBC y MySQL.

## Capas del sistema

### Modelo

Las clases del paquete `modelo` representan los datos principales del negocio. Por ejemplo:

- `Categoria`
- `Proveedor`
- `Cliente`
- `Producto`
- `Venta`
- `DetalleVenta`

Estas clases no consultan directamente la base de datos. Solo almacenan y transportan informacion.

### DAO

Las clases del paquete `dao` se encargan del acceso a datos. Usan JDBC, SQL y `PreparedStatement` para consultar, registrar, actualizar o eliminar informacion en MySQL.

Ejemplos previstos:

- `CategoriaDAO`
- `ProveedorDAO`
- `ClienteDAO`
- `ProductoDAO`
- `VentaDAO`

En esta capa se aplicara `try-with-resources` para cerrar correctamente conexiones, sentencias y resultados.

### Controlador

Las clases del paquete `controlador` seran Servlets. Su trabajo sera recibir peticiones HTTP, leer parametros, validar datos, llamar a los DAO y decidir que vista JSP debe mostrarse.

Ejemplos previstos:

- `CategoriaServlet`
- `ProveedorServlet`
- `ClienteServlet`
- `ProductoServlet`
- `VentaServlet`

### Vista

Las vistas seran paginas JSP ubicadas en `src/main/webapp`. Su responsabilidad sera mostrar formularios, tablas, mensajes y enlaces de navegacion.

Las JSP no deben contener SQL. Tampoco deben concentrar la logica principal del sistema.

## Flujo de un CRUD

1. El usuario abre una pagina de listado, por ejemplo categorias.
2. La peticion llega al Servlet correspondiente.
3. El Servlet llama al DAO para obtener los datos.
4. El DAO consulta MySQL usando JDBC.
5. El Servlet envia los datos a una JSP.
6. La JSP muestra la tabla o formulario.
7. Si el usuario registra, edita o elimina, el Servlet recibe la accion y repite el flujo.

## Flujo de una venta

1. El usuario abre la pagina de nueva venta.
2. El Servlet carga clientes y productos disponibles.
3. La JSP muestra los selectores y campos de cantidad.
4. El usuario envia la venta.
5. El Servlet valida que la cantidad sea mayor a cero y que exista stock suficiente.
6. El Servlet llama a `VentaDAO`.
7. `VentaDAO` registra la venta, registra el detalle y descuenta stock.
8. El sistema redirige al detalle o listado de ventas.

## Idea clave para exposicion

La arquitectura MVC permite que el sistema sea mas ordenado y mantenible porque cada parte tiene una responsabilidad clara:

- El modelo representa datos.
- El DAO conversa con MySQL.
- El Servlet coordina el flujo.
- La JSP muestra la interfaz.
