package controlador;

import dao.ProveedorDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Proveedor;
import util.Validador;

@WebServlet(name = "ProveedorServlet", urlPatterns = {"/proveedores"})
public class ProveedorServlet extends HttpServlet {

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
            } else {
                listar(request, response);
            }
        } catch (SQLException ex) {
            throw new ServletException("Error al procesar proveedores.", ex);
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
            throw new ServletException("Error al guardar proveedor.", ex);
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String busqueda = request.getParameter("busqueda");
        List<Proveedor> proveedores = proveedorDAO.listar(busqueda);
        request.setAttribute("proveedores", proveedores);
        request.setAttribute("busqueda", busqueda);
        request.getRequestDispatcher("/proveedores/listar.jsp").forward(request, response);
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("proveedor", new Proveedor());
        request.getRequestDispatcher("/proveedores/formulario.jsp").forward(request, response);
    }

    private void mostrarEditar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int idProveedor = Validador.convertirEntero(request.getParameter("id"), 0);
        Proveedor proveedor = proveedorDAO.obtenerPorId(idProveedor);

        if (proveedor == null) {
            response.sendRedirect(request.getContextPath() + "/proveedores?error=no_encontrado");
            return;
        }

        request.setAttribute("proveedor", proveedor);
        request.getRequestDispatcher("/proveedores/editar.jsp").forward(request, response);
    }

    private void registrar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Proveedor proveedor = leerProveedor(request);
        String error = validar(proveedor);

        if (error != null) {
            request.setAttribute("errorFormulario", error);
            request.setAttribute("proveedor", proveedor);
            request.getRequestDispatcher("/proveedores/formulario.jsp").forward(request, response);
            return;
        }

        proveedorDAO.registrar(proveedor);
        response.sendRedirect(request.getContextPath() + "/proveedores?mensaje=registrado");
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Proveedor proveedor = leerProveedor(request);
        proveedor.setIdProveedor(Validador.convertirEntero(request.getParameter("idProveedor"), 0));
        String error = validar(proveedor);

        if (proveedor.getIdProveedor() <= 0) {
            error = "El proveedor no es valido.";
        }

        if (error != null) {
            request.setAttribute("errorFormulario", error);
            request.setAttribute("proveedor", proveedor);
            request.getRequestDispatcher("/proveedores/editar.jsp").forward(request, response);
            return;
        }

        proveedorDAO.actualizar(proveedor);
        response.sendRedirect(request.getContextPath() + "/proveedores?mensaje=actualizado");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int idProveedor = Validador.convertirEntero(request.getParameter("id"), 0);

        if (idProveedor <= 0) {
            response.sendRedirect(request.getContextPath() + "/proveedores?error=no_encontrado");
            return;
        }

        boolean eliminado = proveedorDAO.eliminar(idProveedor);
        if (eliminado) {
            response.sendRedirect(request.getContextPath() + "/proveedores?mensaje=eliminado");
        } else {
            response.sendRedirect(request.getContextPath() + "/proveedores?error=relacionado");
        }
    }

    private Proveedor leerProveedor(HttpServletRequest request) {
        Proveedor proveedor = new Proveedor();
        proveedor.setRazonSocial(request.getParameter("razonSocial"));
        proveedor.setRuc(request.getParameter("ruc"));
        proveedor.setTelefono(request.getParameter("telefono"));
        proveedor.setCorreo(request.getParameter("correo"));
        proveedor.setDireccion(request.getParameter("direccion"));
        proveedor.setEstado("1".equals(request.getParameter("estado")));
        return proveedor;
    }

    private String validar(Proveedor proveedor) {
        if (Validador.estaVacio(proveedor.getRazonSocial())) {
            return "La razon social es obligatoria.";
        }
        if (Validador.estaVacio(proveedor.getRuc())) {
            return "El RUC es obligatorio.";
        }
        return null;
    }
}
