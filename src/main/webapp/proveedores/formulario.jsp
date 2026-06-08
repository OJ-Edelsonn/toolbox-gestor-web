<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/navbar.jsp" %>

<main class="container page-content">
    <div class="page-title">
        <div>
            <h1>Nuevo proveedor</h1>
            <p>Registra un proveedor para asociarlo a productos.</p>
        </div>
        <a class="button secondary" href="${pageContext.request.contextPath}/proveedores">Volver</a>
    </div>

    <c:if test="${not empty errorFormulario}">
        <div class="message error">${errorFormulario}</div>
    </c:if>

    <section class="panel">
        <form method="post" action="${pageContext.request.contextPath}/proveedores">
            <input type="hidden" name="accion" value="registrar">

            <div class="form-grid">
                <div class="form-field">
                    <label for="razonSocial">Razon social</label>
                    <input id="razonSocial" type="text" name="razonSocial" value="${proveedor.razonSocial}" maxlength="150" required>
                </div>

                <div class="form-field">
                    <label for="ruc">RUC</label>
                    <input id="ruc" type="text" name="ruc" value="${proveedor.ruc}" maxlength="11" required>
                </div>

                <div class="form-field">
                    <label for="telefono">Telefono</label>
                    <input id="telefono" type="text" name="telefono" value="${proveedor.telefono}" maxlength="20">
                </div>

                <div class="form-field">
                    <label for="correo">Correo</label>
                    <input id="correo" type="email" name="correo" value="${proveedor.correo}" maxlength="120">
                </div>

                <div class="form-field">
                    <label for="estado">Estado</label>
                    <select id="estado" name="estado">
                        <option value="1" selected>Activo</option>
                        <option value="0">Inactivo</option>
                    </select>
                </div>

                <div class="form-field full">
                    <label for="direccion">Direccion</label>
                    <input id="direccion" type="text" name="direccion" value="${proveedor.direccion}" maxlength="200">
                </div>
            </div>

            <div class="actions-bar">
                <button type="submit">Guardar</button>
                <a class="button secondary" href="${pageContext.request.contextPath}/proveedores">Cancelar</a>
            </div>
        </form>
    </section>
</main>

<%@ include file="../includes/footer.jsp" %>
