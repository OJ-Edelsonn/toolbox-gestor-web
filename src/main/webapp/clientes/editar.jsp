<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/navbar.jsp" %>

<main class="container page-content">
    <div class="page-title">
        <div>
            <h1>Editar cliente</h1>
            <p>Actualiza la informacion del cliente seleccionado.</p>
        </div>
        <a class="button secondary" href="${pageContext.request.contextPath}/clientes">Volver</a>
    </div>

    <c:if test="${not empty errorFormulario}">
        <div class="message error">${errorFormulario}</div>
    </c:if>

    <section class="panel">
        <form method="post" action="${pageContext.request.contextPath}/clientes">
            <input type="hidden" name="accion" value="actualizar">
            <input type="hidden" name="idCliente" value="${cliente.idCliente}">

            <div class="form-grid">
                <div class="form-field">
                    <label for="tipoDocumento">Tipo documento</label>
                    <select id="tipoDocumento" name="tipoDocumento">
                        <option value="DNI" ${cliente.tipoDocumento == 'DNI' ? 'selected' : ''}>DNI</option>
                        <option value="RUC" ${cliente.tipoDocumento == 'RUC' ? 'selected' : ''}>RUC</option>
                    </select>
                </div>

                <div class="form-field">
                    <label for="numeroDocumento">Numero documento</label>
                    <input id="numeroDocumento" type="text" name="numeroDocumento" value="${cliente.numeroDocumento}" maxlength="11" required>
                </div>

                <div class="form-field">
                    <label for="nombres">Nombres</label>
                    <input id="nombres" type="text" name="nombres" value="${cliente.nombres}" maxlength="100">
                </div>

                <div class="form-field">
                    <label for="apellidos">Apellidos</label>
                    <input id="apellidos" type="text" name="apellidos" value="${cliente.apellidos}" maxlength="100">
                </div>

                <div class="form-field full">
                    <label for="razonSocial">Razon social</label>
                    <input id="razonSocial" type="text" name="razonSocial" value="${cliente.razonSocial}" maxlength="150">
                </div>

                <div class="form-field">
                    <label for="telefono">Telefono</label>
                    <input id="telefono" type="text" name="telefono" value="${cliente.telefono}" maxlength="20">
                </div>

                <div class="form-field">
                    <label for="correo">Correo</label>
                    <input id="correo" type="email" name="correo" value="${cliente.correo}" maxlength="120">
                </div>

                <div class="form-field">
                    <label for="estado">Estado</label>
                    <select id="estado" name="estado">
                        <option value="1" ${cliente.estado ? 'selected' : ''}>Activo</option>
                        <option value="0" ${!cliente.estado ? 'selected' : ''}>Inactivo</option>
                    </select>
                </div>

                <div class="form-field full">
                    <label for="direccion">Direccion</label>
                    <input id="direccion" type="text" name="direccion" value="${cliente.direccion}" maxlength="200">
                </div>
            </div>

            <div class="actions-bar">
                <button type="submit">Actualizar</button>
                <a class="button secondary" href="${pageContext.request.contextPath}/clientes">Cancelar</a>
            </div>
        </form>
    </section>
</main>

<%@ include file="../includes/footer.jsp" %>
