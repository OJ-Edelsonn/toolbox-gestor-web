<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/navbar.jsp" %>

<main class="container page-content">
    <div class="page-title">
        <div>
            <h1>Ventas</h1>
            <p>Modulo reservado para la segunda parte del proyecto.</p>
        </div>
        <a class="button secondary" href="${pageContext.request.contextPath}/">Ir al inicio</a>
    </div>

    <section class="panel">
        <h2>Estado del modulo</h2>
        <p>
            En esta primera entrega se implemento la base MVC, conexion JDBC,
            mantenimientos de categorias, proveedores, clientes, productos y bajo stock.
        </p>
        <p>
            En la segunda entrega se completara el registro de ventas con detalle,
            validacion de stock suficiente, calculo de subtotales y descuento automatico de inventario.
        </p>
    </section>
</main>

<%@ include file="../includes/footer.jsp" %>
