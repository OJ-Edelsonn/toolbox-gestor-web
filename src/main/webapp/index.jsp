<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>

<header class="app-header">
    <div class="container">
        <p class="eyebrow">J&amp;S Ferreteria</p>
        <h1>ToolBox Gestor Web</h1>
        <p class="lead">Sistema Web de Gestion de Ventas e Inventario</p>
    </div>
</header>

<main class="container page-content">
    <section class="intro-grid">
        <div class="panel">
            <h2>Proposito del sistema</h2>
            <p>
                Aplicacion web academica para organizar categorias, proveedores,
                clientes, productos, ventas e inventario basico de J&amp;S Ferreteria.
            </p>
            <p>
                El proyecto aplica arquitectura MVC con JSP, Servlets, DAO, JDBC y MySQL.
            </p>
        </div>

        <div class="panel">
            <h2>Avance actual</h2>
            <p>
                El sistema ya cuenta con estructura MVC, script de base de datos,
                conexion JDBC y layout JSP reutilizable.
            </p>
            <p>
                Las ventas completas se implementaran en la segunda parte del proyecto.
            </p>
        </div>
    </section>

    <section class="section-heading">
        <h2>Accesos rapidos</h2>
    </section>

    <section class="quick-links" aria-label="Accesos rapidos">
        <a href="${pageContext.request.contextPath}/categorias" class="quick-link">Categorias</a>
        <a href="${pageContext.request.contextPath}/proveedores" class="quick-link">Proveedores</a>
        <a href="${pageContext.request.contextPath}/clientes" class="quick-link">Clientes</a>
        <a href="${pageContext.request.contextPath}/productos" class="quick-link">Productos</a>
        <a href="${pageContext.request.contextPath}/productos?accion=bajoStock" class="quick-link">Bajo stock</a>
        <a href="${pageContext.request.contextPath}/ventas" class="quick-link">Ventas</a>
    </section>
</main>

<%@ include file="includes/footer.jsp" %>
