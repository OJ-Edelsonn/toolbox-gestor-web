package controlador;

import dao.CategoriaDAO;
import dao.ProductoDAO;
import dao.ProveedorDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Categoria;
import modelo.Producto;
import modelo.Proveedor;
import util.Validador;

@WebServlet(name = "ProductoServlet", urlPatterns = {"/productos"})
public class ProductoServlet extends HttpServlet {

    private static final String[] UNIDADES = {
        "Unidad", "Caja", "Bolsa", "Metro", "Kilogramo", "Litro", "Galon", "Paquete"
    };

    private final ProductoDAO productoDAO = new ProductoDAO();
    private final CategoriaDAO categoriaDAO = new CategoriaDAO();
    private final ProveedorDAO proveedorDAO = new ProveedorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        try {
            if ("nuevo".equals(accion)) {
                mostrarFormulario(request, response);
            } else if ("editar".equals(accion)) {
                mostrarEditar(request, response);
            } else if ("eliminar".equals(accion)) {
                eliminar(request, response);
            } else if ("bajoStock".equals(accion)) {
                bajoStock(request, response);
            } else {
                listar(request, response);
            }
        } catch (SQLException ex) {
            throw new ServletException("Error al procesar productos.", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        try {
            if ("actualizar".equals(accion)) {
                actualizar(request, response);
            } else {
                registrar(request, response);
            }
        } catch (SQLException ex) {
            throw new ServletException("Error al guardar producto.", ex);
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String busqueda = request.getParameter("busqueda");
        List<Producto> productos = productoDAO.listar(busqueda);
        request.setAttribute("productos", productos);
        request.setAttribute("busqueda", busqueda);
        request.getRequestDispatcher("/productos/listar.jsp").forward(request, response);
    }

    private void bajoStock(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Producto> productos = productoDAO.listarBajoStock();
        request.setAttribute("productos", productos);
        request.getRequestDispatcher("/productos/bajo-stock.jsp").forward(request, response);
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Producto producto = new Producto();
        producto.setEstado(true);
        producto.setUnidadMedida("Unidad");
        request.setAttribute("producto", producto);
        cargarCombos(request);
        request.getRequestDispatcher("/productos/formulario.jsp").forward(request, response);
    }

    private void mostrarEditar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int idProducto = Validador.convertirEntero(request.getParameter("id"), 0);
        Producto producto = productoDAO.obtenerPorId(idProducto);

        if (producto == null) {
            response.sendRedirect(request.getContextPath() + "/productos?error=no_encontrado");
            return;
        }

        request.setAttribute("producto", producto);
        cargarCombos(request);
        request.getRequestDispatcher("/productos/editar.jsp").forward(request, response);
    }

    private void registrar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Producto producto = leerProducto(request);
        String error = validar(producto);

        if (error != null) {
            request.setAttribute("errorFormulario", error);
            request.setAttribute("producto", producto);
            cargarCombos(request);
            request.getRequestDispatcher("/productos/formulario.jsp").forward(request, response);
            return;
        }

        productoDAO.registrar(producto);
        response.sendRedirect(request.getContextPath() + "/productos?mensaje=registrado");
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Producto producto = leerProducto(request);
        producto.setIdProducto(Validador.convertirEntero(request.getParameter("idProducto"), 0));
        String error = validar(producto);

        if (producto.getIdProducto() <= 0) {
            error = "El producto no es valido.";
        }

        if (error != null) {
            request.setAttribute("errorFormulario", error);
            request.setAttribute("producto", producto);
            cargarCombos(request);
            request.getRequestDispatcher("/productos/editar.jsp").forward(request, response);
            return;
        }

        productoDAO.actualizar(producto);
        response.sendRedirect(request.getContextPath() + "/productos?mensaje=actualizado");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int idProducto = Validador.convertirEntero(request.getParameter("id"), 0);

        if (idProducto <= 0) {
            response.sendRedirect(request.getContextPath() + "/productos?error=no_encontrado");
            return;
        }

        boolean eliminado = productoDAO.eliminar(idProducto);
        if (eliminado) {
            response.sendRedirect(request.getContextPath() + "/productos?mensaje=eliminado");
        } else {
            response.sendRedirect(request.getContextPath() + "/productos?error=relacionado");
        }
    }

    private Producto leerProducto(HttpServletRequest request) {
        Producto producto = new Producto();
        producto.setCodigoProducto(request.getParameter("codigoProducto"));
        producto.setNombreProducto(request.getParameter("nombreProducto"));
        producto.setDescripcion(request.getParameter("descripcion"));
        producto.setIdCategoria(Validador.convertirEntero(request.getParameter("idCategoria"), 0));
        producto.setIdProveedor(Validador.convertirEntero(request.getParameter("idProveedor"), 0));
        producto.setUnidadMedida(request.getParameter("unidadMedida"));
        producto.setPrecioCompra(Validador.convertirDecimal(request.getParameter("precioCompra"), BigDecimal.ZERO));
        producto.setPrecioVenta(Validador.convertirDecimal(request.getParameter("precioVenta"), BigDecimal.ZERO));
        producto.setStock(Validador.convertirEntero(request.getParameter("stock"), -1));
        producto.setStockMinimo(Validador.convertirEntero(request.getParameter("stockMinimo"), -1));
        producto.setEstado("1".equals(request.getParameter("estado")));
        return producto;
    }

    private String validar(Producto producto) {
        if (Validador.estaVacio(producto.getCodigoProducto())) {
            return "El codigo del producto es obligatorio.";
        }
        if (Validador.estaVacio(producto.getNombreProducto())) {
            return "El nombre del producto es obligatorio.";
        }
        if (producto.getIdCategoria() <= 0) {
            return "Debe seleccionar una categoria.";
        }
        if (producto.getIdProveedor() <= 0) {
            return "Debe seleccionar un proveedor.";
        }
        if (Validador.estaVacio(producto.getUnidadMedida())) {
            return "La unidad de medida es obligatoria.";
        }
        if (!Validador.esDecimalPositivo(producto.getPrecioCompra())) {
            return "El precio de compra debe ser mayor a cero.";
        }
        if (!Validador.esDecimalPositivo(producto.getPrecioVenta())) {
            return "El precio de venta debe ser mayor a cero.";
        }
        if (!Validador.esEnteroNoNegativo(producto.getStock())) {
            return "El stock no puede ser negativo.";
        }
        if (!Validador.esEnteroNoNegativo(producto.getStockMinimo())) {
            return "El stock minimo no puede ser negativo.";
        }
        return null;
    }

    private void cargarCombos(HttpServletRequest request) throws SQLException {
        List<Categoria> categorias = categoriaDAO.listar(null);
        List<Proveedor> proveedores = proveedorDAO.listar(null);
        request.setAttribute("categorias", categorias);
        request.setAttribute("proveedores", proveedores);
        request.setAttribute("unidades", UNIDADES);
    }
}
