# ToolBox Gestor Web

Sistema Web de Gestion de Ventas e Inventario para J&S Ferreteria.

## Estado del proyecto

Fase actual: avance parcial aproximado del 60%.

Este repositorio se desarrollara por fases para que el codigo sea entendible y defendible en exposicion academica. El sistema usara Java Web clasico con arquitectura MVC, JSP, Servlets, JDBC y MySQL.

## Empresa

J&S Ferreteria es una ferreteria familiar ubicada en Quiparacra, Pasco. El sistema busca ordenar la gestion de productos, categorias, proveedores, clientes, ventas e inventario basico.

## Tecnologias

- Java 17
- JSP
- Servlets con `javax.servlet`
- JDBC
- MySQL desde XAMPP
- Apache Tomcat 9
- NetBeans
- HTML
- CSS
- Git y GitHub

## Entorno confirmado

- Java: OpenJDK Temurin 17.0.19
- Git: disponible en consola
- Tomcat elegido: Apache Tomcat 9.0.117
- Ruta Tomcat elegida: `C:\Program Files\Apache Software Foundation\Tomcat 9.0`
- MySQL esperado: XAMPP, usuario `root`, clave vacia, puerto `3306`
- Maven: no esta disponible en el PATH de la consola; NetBeans puede abrir proyectos Maven usando su Maven integrado. Tambien se puede instalar Maven aparte si se desea compilar desde terminal.

## Base de datos

Nombre de base de datos:

```text
bd_toolbox_gestor_web
```

URL JDBC prevista:

```java
String url = "jdbc:mysql://localhost:3306/bd_toolbox_gestor_web?useSSL=false&serverTimezone=America/Lima&allowPublicKeyRetrieval=true";
String usuario = "root";
String clave = "";
```

Driver JDBC:

```text
com.mysql.cj.jdbc.Driver
```

## Estructura MVC

```text
src/main/java/
  modelo/
  dao/
  controlador/
  util/

src/main/webapp/
  index.jsp
  css/
  includes/
  categorias/
  proveedores/
  productos/
  clientes/
  ventas/
```

## Modulos implementados en este avance

- Pagina principal.
- Script de base de datos con datos de prueba.
- Conexion JDBC.
- Layout JSP reutilizable.
- CRUD de categorias.
- CRUD de proveedores.
- CRUD de clientes.
- CRUD de productos.
- Consulta de productos con bajo stock.

## Modulos pendientes para la segunda entrega

- Registro de ventas.
- Detalle de venta.
- Validacion de stock en ventas.
- Descuento automatico de stock.
- Documentacion final y manual de usuario.

## Alineacion con la evaluacion

El proyecto esta orientado a demostrar la implementacion de una aplicacion web con JSP, Servlets y arquitectura MVC. Para responder a los indicadores de evaluacion, se reforzaran estos criterios durante el desarrollo:

- Arquitectura MVC: separacion clara entre modelos, DAO, Servlets y JSP.
- Interfaces JSP y CSS: paginas ordenadas, sobrias y faciles de explicar.
- Java Web clasico: uso de Servlets como controladores y JSP como vistas.
- Acceso a datos: conexion JDBC con MySQL, `PreparedStatement` y cierre correcto de recursos.
- Exposicion: documentacion preparada para explicar problema, solucion, flujo MVC y reglas de negocio.

## Criterios tecnicos reforzados

- Eficiencia: consultas SQL simples, busquedas controladas y operaciones directas sobre las tablas necesarias.
- Mantenibilidad: paquetes separados, nombres claros y codigo organizado por responsabilidad.
- Gestion de recursos: uso de `try-with-resources` en DAO para cerrar `Connection`, `PreparedStatement` y `ResultSet`.
- Dominio del tema: cada fase tendra una explicacion breve del flujo implementado.
- Solucion al entorno: el sistema responde al problema real de registros manuales, errores de stock y demoras en consulta de ventas e inventario.

## Flujo MVC resumido

1. La JSP muestra una tabla o formulario.
2. El usuario envia una accion.
3. El Servlet recibe la peticion.
4. El Servlet valida datos y llama al DAO.
5. El DAO usa JDBC y `PreparedStatement`.
6. MySQL devuelve o actualiza informacion.
7. El Servlet redirige o reenvia a una JSP.
8. La JSP muestra el resultado.

## Repositorio GitHub

Repositorio final previsto:

```text
toolbox-gestor-web
```

Visibilidad prevista: publico.

El repositorio remoto sera creado manualmente desde GitHub. Luego se conectara el proyecto local con estos comandos:

```bash
git init
git add .
git commit -m "Configura estructura inicial del proyecto"
git branch -M main
git remote add origin URL_DEL_REPOSITORIO
git push -u origin main
```

## Fases de trabajo

1. Confirmacion del entorno.
2. Proyecto base.
3. Base de datos.
4. Conexion JDBC y layout.
5. CRUD categorias.
6. CRUD proveedores.
7. CRUD clientes.
8. CRUD productos y bajo stock.
9. Ventas y descuento de stock.
10. Documentacion final y GitHub.

## Datos de referencia

Se revisara el proyecto `C:\xampp\htdocs\ferreteria-inteligente` como referencia comercial. Se reutilizaran nombres de categorias y productos cuando convenga, y se completara con datos sinteticos realistas para cubrir proveedores, clientes, ventas y stock.
