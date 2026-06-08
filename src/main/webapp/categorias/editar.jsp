<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/navbar.jsp" %>

<main class="container page-content">
    <div class="page-title">
        <div>
            <h1>Editar categoria</h1>
            <p>Actualiza los datos de una categoria existente.</p>
        </div>
        <a class="button secondary" href="${pageContext.request.contextPath}/categorias">Volver</a>
    </div>

    <c:if test="${not empty errorFormulario}">
        <div class="message error">${errorFormulario}</div>
    </c:if>

    <section class="panel">
        <form method="post" action="${pageContext.request.contextPath}/categorias">
            <input type="hidden" name="accion" value="actualizar">
            <input type="hidden" name="idCategoria" value="${categoria.idCategoria}">

            <div class="form-grid">
                <div class="form-field">
                    <label for="nombre">Nombre</label>
                    <input id="nombre" type="text" name="nombre" value="${categoria.nombre}" maxlength="100" required>
                </div>

                <div class="form-field">
                    <label for="estado">Estado</label>
                    <select id="estado" name="estado">
                        <option value="1" ${categoria.estado ? 'selected' : ''}>Activo</option>
                        <option value="0" ${!categoria.estado ? 'selected' : ''}>Inactivo</option>
                    </select>
                </div>

                <div class="form-field full">
                    <label for="descripcion">Descripcion</label>
                    <textarea id="descripcion" name="descripcion" maxlength="255">${categoria.descripcion}</textarea>
                </div>
            </div>

            <div class="actions-bar">
                <button type="submit">Actualizar</button>
                <a class="button secondary" href="${pageContext.request.contextPath}/categorias">Cancelar</a>
            </div>
        </form>
    </section>
</main>

<%@ include file="../includes/footer.jsp" %>
