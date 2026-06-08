<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/navbar.jsp" %>

<main class="container page-content">
    <div class="page-title">
        <div>
            <h1>Productos con bajo stock</h1>
            <p>Productos cuyo stock actual es menor o igual al stock minimo.</p>
        </div>
        <a class="button secondary" href="${pageContext.request.contextPath}/productos">Volver a productos</a>
    </div>

    <c:choose>
        <c:when test="${empty productos}">
            <div class="empty-state">No hay productos con bajo stock.</div>
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
                            <th>Stock actual</th>
                            <th>Stock minimo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="producto" items="${productos}">
                            <tr>
                                <td>${producto.codigoProducto}</td>
                                <td>${producto.nombreProducto}</td>
                                <td>${producto.nombreCategoria}</td>
                                <td>${producto.razonSocialProveedor}</td>
                                <td>${producto.stock}</td>
                                <td>${producto.stockMinimo}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<%@ include file="../includes/footer.jsp" %>
