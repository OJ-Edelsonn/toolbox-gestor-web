<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="form-grid">
    <div class="form-field">
        <label for="codigoProducto">Codigo</label>
        <input id="codigoProducto" type="text" name="codigoProducto" value="${producto.codigoProducto}" maxlength="20" required>
    </div>

    <div class="form-field">
        <label for="nombreProducto">Nombre</label>
        <input id="nombreProducto" type="text" name="nombreProducto" value="${producto.nombreProducto}" maxlength="150" required>
    </div>

    <div class="form-field">
        <label for="idCategoria">Categoria</label>
        <select id="idCategoria" name="idCategoria" required>
            <option value="0">Seleccione</option>
            <c:forEach var="categoria" items="${categorias}">
                <option value="${categoria.idCategoria}" ${producto.idCategoria == categoria.idCategoria ? 'selected' : ''}>${categoria.nombre}</option>
            </c:forEach>
        </select>
    </div>

    <div class="form-field">
        <label for="idProveedor">Proveedor</label>
        <select id="idProveedor" name="idProveedor" required>
            <option value="0">Seleccione</option>
            <c:forEach var="proveedor" items="${proveedores}">
                <option value="${proveedor.idProveedor}" ${producto.idProveedor == proveedor.idProveedor ? 'selected' : ''}>${proveedor.razonSocial}</option>
            </c:forEach>
        </select>
    </div>

    <div class="form-field">
        <label for="unidadMedida">Unidad de medida</label>
        <select id="unidadMedida" name="unidadMedida" required>
            <option value="">Seleccione</option>
            <c:forEach var="unidad" items="${unidades}">
                <option value="${unidad}" ${producto.unidadMedida == unidad ? 'selected' : ''}>${unidad}</option>
            </c:forEach>
        </select>
    </div>

    <div class="form-field">
        <label for="estado">Estado</label>
        <select id="estado" name="estado">
            <option value="1" ${producto.estado ? 'selected' : ''}>Activo</option>
            <option value="0" ${!producto.estado ? 'selected' : ''}>Inactivo</option>
        </select>
    </div>

    <div class="form-field">
        <label for="precioCompra">Precio compra</label>
        <input id="precioCompra" type="number" step="0.01" min="0.01" name="precioCompra" value="${producto.precioCompra}" required>
    </div>

    <div class="form-field">
        <label for="precioVenta">Precio venta</label>
        <input id="precioVenta" type="number" step="0.01" min="0.01" name="precioVenta" value="${producto.precioVenta}" required>
    </div>

    <div class="form-field">
        <label for="stock">Stock</label>
        <input id="stock" type="number" min="0" name="stock" value="${producto.stock}" required>
    </div>

    <div class="form-field">
        <label for="stockMinimo">Stock minimo</label>
        <input id="stockMinimo" type="number" min="0" name="stockMinimo" value="${producto.stockMinimo}" required>
    </div>

    <div class="form-field full">
        <label for="descripcion">Descripcion</label>
        <textarea id="descripcion" name="descripcion" maxlength="255">${producto.descripcion}</textarea>
    </div>
</div>
