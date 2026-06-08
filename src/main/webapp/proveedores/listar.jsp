<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/navbar.jsp" %>

<main class="container page-content">
    <div class="page-title">
        <div>
            <h1>Proveedores</h1>
            <p>Gestion de empresas que abastecen productos a la ferreteria.</p>
        </div>
        <a class="button" href="${pageContext.request.contextPath}/proveedores?accion=nuevo">Nuevo proveedor</a>
    </div>

    <c:if test="${param.mensaje == 'registrado'}">
        <div class="message">Proveedor registrado correctamente.</div>
    </c:if>
    <c:if test="${param.mensaje == 'actualizado'}">
        <div class="message">Proveedor actualizado correctamente.</div>
    </c:if>
    <c:if test="${param.mensaje == 'eliminado'}">
        <div class="message">Proveedor eliminado correctamente.</div>
    </c:if>
    <c:if test="${param.error == 'relacionado'}">
        <div class="message error">No se puede eliminar el proveedor porque tiene productos asociados.</div>
    </c:if>
    <c:if test="${param.error == 'no_encontrado'}">
        <div class="message error">No se encontro el proveedor solicitado.</div>
    </c:if>

    <div class="actions-bar">
        <form class="search-form" method="get" action="${pageContext.request.contextPath}/proveedores">
            <input type="text" name="busqueda" value="${busqueda}" placeholder="Buscar por razon social o RUC">
            <button type="submit">Buscar</button>
            <a class="button secondary" href="${pageContext.request.contextPath}/proveedores">Limpiar</a>
        </form>
    </div>

    <c:choose>
        <c:when test="${empty proveedores}">
            <div class="empty-state">No hay proveedores registrados.</div>
        </c:when>
        <c:otherwise>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Razon social</th>
                            <th>RUC</th>
                            <th>Telefono</th>
                            <th>Correo</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="proveedor" items="${proveedores}">
                            <tr>
                                <td>${proveedor.idProveedor}</td>
                                <td>${proveedor.razonSocial}</td>
                                <td>${proveedor.ruc}</td>
                                <td>${proveedor.telefono}</td>
                                <td>${proveedor.correo}</td>
                                <td>${proveedor.estado ? 'Activo' : 'Inactivo'}</td>
                                <td>
                                    <div class="row-actions">
                                        <a class="button muted" href="${pageContext.request.contextPath}/proveedores?accion=editar&id=${proveedor.idProveedor}">Editar</a>
                                        <a class="button secondary" href="${pageContext.request.contextPath}/proveedores?accion=eliminar&id=${proveedor.idProveedor}" onclick="return confirm('Desea eliminar este proveedor?');">Eliminar</a>
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
