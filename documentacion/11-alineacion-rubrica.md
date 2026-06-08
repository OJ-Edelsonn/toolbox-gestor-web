# Alineacion con la Rubrica

## Actividad

El proyecto corresponde a una aplicacion web aplicada con exposicion. La solucion se centra en reconocer e implementar JSP, Servlets y arquitectura MVC para resolver un problema real de organizacion de ventas e inventario en J&S Ferreteria.

## Indicadores de evaluacion

### Reconocimiento de la arquitectura MVC

El proyecto separara responsabilidades en cuatro partes:

- `modelo`: entidades del negocio.
- `dao`: acceso a datos con JDBC.
- `controlador`: Servlets que procesan peticiones.
- `webapp`: JSP, CSS e interfaces.

Esta separacion permite explicar claramente que hace cada archivo y como se comunican las capas.

### Diseno de interfaces con JSP y CSS

Las paginas JSP mostraran formularios, tablas, filtros, botones y mensajes. El archivo `estilos.css` definira una interfaz sobria con blanco, negro y grises, adecuada para una presentacion academica.

### Desarrollo con Java Web

El sistema usara Java 17, Servlets y JSP sobre Apache Tomcat 9. Los Servlets actuaran como controladores y las JSP como vistas.

### Procesamiento de datos y base de datos

El sistema procesara registros de categorias, proveedores, clientes, productos y ventas. El acceso a MySQL se realizara con JDBC y `PreparedStatement`.

Las ventas incluiran una regla importante: no permitir vender mas unidades que el stock disponible.

### Comunicacion efectiva y dominio del tema

La documentacion explicara:

- Problema del negocio.
- Objetivos del sistema.
- Reglas de negocio.
- Estructura MVC.
- Modelo de base de datos.
- Flujo de CRUD.
- Flujo de venta y descuento de stock.

## Criterios reforzados

### Eficiencia

Se usaran consultas SQL directas, filtros simples y operaciones enfocadas en los datos necesarios. El sistema no tendra modulos innecesarios que compliquen la ejecucion.

### Mantenibilidad

El codigo se organizara por paquetes y responsabilidades. Esto facilita corregir errores, agregar modulos y explicar el sistema por partes.

### Gestion de recursos

Los DAO cerraran recursos con `try-with-resources`. Esto evita dejar conexiones abiertas y demuestra buen uso de JDBC.

### Presentacion de solucion al entorno

ToolBox Gestor Web responde a necesidades concretas de una ferreteria familiar:

- Registrar productos de forma ordenada.
- Consultar stock.
- Registrar clientes y proveedores.
- Registrar ventas.
- Descontar stock automaticamente.
- Identificar productos con bajo stock.

### Dominio para exposicion

Cada modulo se desarrollara por fases. Esto permitira explicar de forma progresiva como una peticion pasa por JSP, Servlet, DAO, modelo y base de datos.
