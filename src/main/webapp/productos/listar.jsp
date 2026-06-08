<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/navbar.jsp" %>

<main class="container page-content">
    <div class="page-title">
        <div>
            <h1>Productos</h1>
            <p>Gestion de catalogo, precios, proveedores y stock.</p>
        </div>
        <a class="button" href="${pageContext.request.contextPath}/productos?accion=nuevo">Nuevo producto</a>
    </div>

    <c:if test="${param.mensaje == 'registrado'}">
        <div class="message">Producto registrado correctamente.</div>
    </c:if>
    <c:if test="${param.mensaje == 'actualizado'}">
        <div class="message">Producto actualizado correctamente.</div>
    </c:if>
    <c:if test="${param.mensaje == 'eliminado'}">
        <div class="message">Producto eliminado correctamente.</div>
    </c:if>
    <c:if test="${param.error == 'relacionado'}">
        <div class="message error">No se puede eliminar el producto porque tiene ventas asociadas.</div>
    </c:if>
    <c:if test="${param.error == 'no_encontrado'}">
        <div class="message error">No se encontro el producto solicitado.</div>
    </c:if>

    <div class="actions-bar">
        <form class="search-form" method="get" action="${pageContext.request.contextPath}/productos">
            <input type="text" name="busqueda" value="${busqueda}" placeholder="Buscar por codigo, nombre, categoria o proveedor">
            <button type="submit">Buscar</button>
            <a class="button secondary" href="${pageContext.request.contextPath}/productos">Limpiar</a>
        </form>
        <a class="button secondary" href="${pageContext.request.contextPath}/productos?accion=bajoStock">Ver bajo stock</a>
    </div>

    <c:choose>
        <c:when test="${empty productos}">
            <div class="empty-state">No hay productos registrados.</div>
        </c:when>
        <c:otherwise>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Codigo</th>
                            <th>Producto</th>
                            <th>Categoria</th>
                            <th>Proveedor</th>
                            <th>Precio venta</th>
                            <th>Stock</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="producto" items="${productos}">
                            <tr>
                                <td>${producto.codigoProducto}</td>
                                <td>${producto.nombreProducto}</td>
                                <td>${producto.nombreCategoria}</td>
                                <td>${producto.razonSocialProveedor}</td>
                                <td>S/ <fmt:formatNumber value="${producto.precioVenta}" minFractionDigits="2" maxFractionDigits="2"/></td>
                                <td>${producto.stock} / min. ${producto.stockMinimo}</td>
                                <td>${producto.estado ? 'Activo' : 'Inactivo'}</td>
                                <td>
                                    <div class="row-actions">
                                        <a class="button muted" href="${pageContext.request.contextPath}/productos?accion=editar&id=${producto.idProducto}">Editar</a>
                                        <a class="button secondary" href="${pageContext.request.contextPath}/productos?accion=eliminar&id=${producto.idProducto}" onclick="return confirm('Desea eliminar este producto?');">Eliminar</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<%@ include file="../includes/footer.jsp" %>
