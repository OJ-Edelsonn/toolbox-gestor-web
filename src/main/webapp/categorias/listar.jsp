<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/navbar.jsp" %>

<main class="container page-content">
    <div class="page-title">
        <div>
            <h1>Categorias</h1>
            <p>Gestion de grupos de productos de la ferreteria.</p>
        </div>
        <a class="button" href="${pageContext.request.contextPath}/categorias?accion=nuevo">Nueva categoria</a>
    </div>

    <c:if test="${param.mensaje == 'registrado'}">
        <div class="message">Categoria registrada correctamente.</div>
    </c:if>
    <c:if test="${param.mensaje == 'actualizado'}">
        <div class="message">Categoria actualizada correctamente.</div>
    </c:if>
    <c:if test="${param.mensaje == 'eliminado'}">
        <div class="message">Categoria eliminada correctamente.</div>
    </c:if>
    <c:if test="${param.error == 'relacionado'}">
        <div class="message error">No se puede eliminar la categoria porque tiene productos asociados.</div>
    </c:if>
    <c:if test="${param.error == 'no_encontrado'}">
        <div class="message error">No se encontro la categoria solicitada.</div>
    </c:if>

    <div class="actions-bar">
        <form class="search-form" method="get" action="${pageContext.request.contextPath}/categorias">
            <input type="text" name="busqueda" value="${busqueda}" placeholder="Buscar por nombre">
            <button type="submit">Buscar</button>
            <a class="button secondary" href="${pageContext.request.contextPath}/categorias">Limpiar</a>
        </form>
    </div>

    <c:choose>
        <c:when test="${empty categorias}">
            <div class="empty-state">No hay categorias registradas.</div>
        </c:when>
        <c:otherwise>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Descripcion</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="categoria" items="${categorias}">
                            <tr>
                                <td>${categoria.idCategoria}</td>
                                <td>${categoria.nombre}</td>
                                <td>${categoria.descripcion}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${categoria.estado}">Activo</c:when>
                                        <c:otherwise>Inactivo</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="row-actions">
                                        <a class="button muted" href="${pageContext.request.contextPath}/categorias?accion=editar&id=${categoria.idCategoria}">Editar</a>
                                        <a class="button secondary" href="${pageContext.request.contextPath}/categorias?accion=eliminar&id=${categoria.idCategoria}" onclick="return confirm('Desea eliminar esta categoria?');">Eliminar</a>
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
