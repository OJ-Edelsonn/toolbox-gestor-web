<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/navbar.jsp" %>

<main class="container page-content">
    <div class="page-title">
        <div>
            <h1>Clientes</h1>
            <p>Gestion de personas y empresas que realizan compras.</p>
        </div>
        <a class="button" href="${pageContext.request.contextPath}/clientes?accion=nuevo">Nuevo cliente</a>
    </div>

    <c:if test="${param.mensaje == 'registrado'}">
        <div class="message">Cliente registrado correctamente.</div>
    </c:if>
    <c:if test="${param.mensaje == 'actualizado'}">
        <div class="message">Cliente actualizado correctamente.</div>
    </c:if>
    <c:if test="${param.mensaje == 'eliminado'}">
        <div class="message">Cliente eliminado correctamente.</div>
    </c:if>
    <c:if test="${param.error == 'relacionado'}">
        <div class="message error">No se puede eliminar el cliente porque tiene ventas asociadas.</div>
    </c:if>
    <c:if test="${param.error == 'no_encontrado'}">
        <div class="message error">No se encontro el cliente solicitado.</div>
    </c:if>

    <div class="actions-bar">
        <form class="search-form" method="get" action="${pageContext.request.contextPath}/clientes">
            <input type="text" name="busqueda" value="${busqueda}" placeholder="Buscar por nombre, apellido, DNI o RUC">
            <button type="submit">Buscar</button>
            <a class="button secondary" href="${pageContext.request.contextPath}/clientes">Limpiar</a>
        </form>
    </div>

    <c:choose>
        <c:when test="${empty clientes}">
            <div class="empty-state">No hay clientes registrados.</div>
        </c:when>
        <c:otherwise>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Documento</th>
                            <th>Cliente</th>
                            <th>Telefono</th>
                            <th>Correo</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cliente" items="${clientes}">
                            <tr>
                                <td>${cliente.idCliente}</td>
                                <td>${cliente.tipoDocumento} ${cliente.numeroDocumento}</td>
                                <td>${cliente.nombreMostrar}</td>
                                <td>${cliente.telefono}</td>
                                <td>${cliente.correo}</td>
                                <td>${cliente.estado ? 'Activo' : 'Inactivo'}</td>
                                <td>
                                    <div class="row-actions">
                                        <a class="button muted" href="${pageContext.request.contextPath}/clientes?accion=editar&id=${cliente.idCliente}">Editar</a>
                                        <a class="button secondary" href="${pageContext.request.contextPath}/clientes?accion=eliminar&id=${cliente.idCliente}" onclick="return confirm('Desea eliminar este cliente?');">Eliminar</a>
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
