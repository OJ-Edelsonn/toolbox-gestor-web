<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToolBox Gestor Web</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
    <header class="app-header">
        <div class="container">
            <p class="eyebrow">J&amp;S Ferreteria</p>
            <h1>ToolBox Gestor Web</h1>
            <p class="lead">Sistema Web de Gestion de Ventas e Inventario</p>
        </div>
    </header>

    <main class="container main-grid">
        <section class="panel">
            <h2>Proyecto base</h2>
            <p>
                Esta pantalla confirma que la estructura Java Web esta creada.
                En las siguientes fases se conectaran los Servlets, DAO, modelos y vistas JSP.
            </p>
        </section>

        <section class="quick-links" aria-label="Accesos rapidos">
            <a href="#" class="quick-link">Categorias</a>
            <a href="#" class="quick-link">Proveedores</a>
            <a href="#" class="quick-link">Clientes</a>
            <a href="#" class="quick-link">Productos</a>
            <a href="#" class="quick-link">Ventas</a>
            <a href="#" class="quick-link">Bajo stock</a>
        </section>
    </main>

    <footer class="app-footer">
        <div class="container">
            <span>Java Web clasico MVC - JSP, Servlets, JDBC y MySQL</span>
        </div>
    </footer>
</body>
</html>
