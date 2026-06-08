<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/navbar.jsp" %>

<main class="container page-content">
    <div class="page-title">
        <div>
            <h1>Editar producto</h1>
            <p>Actualiza la informacion comercial y de inventario.</p>
        </div>
        <a class="button secondary" href="${pageContext.request.contextPath}/productos">Volver</a>
    </div>

    <c:if test="${not empty errorFormulario}">
        <div class="message error">${errorFormulario}</div>
    </c:if>

    <section class="panel">
        <form method="post" action="${pageContext.request.contextPath}/productos">
            <input type="hidden" name="accion" value="actualizar">
            <input type="hidden" name="idProducto" value="${producto.idProducto}">

            <%@ include file="formulario-campos.jsp" %>

            <div class="actions-bar">
                <button type="submit">Actualizar</button>
                <a class="button secondary" href="${pageContext.request.contextPath}/productos">Cancelar</a>
            </div>
        </form>
    </section>
</main>

<%@ include file="../includes/footer.jsp" %>
