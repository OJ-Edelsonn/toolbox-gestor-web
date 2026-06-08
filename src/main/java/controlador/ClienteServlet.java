package controlador;

import dao.ClienteDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Cliente;
import util.Validador;

@WebServlet(name = "ClienteServlet", urlPatterns = {"/clientes"})
public class ClienteServlet extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();

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
            throw new ServletException("Error al procesar clientes.", ex);
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
            throw new ServletException("Error al guardar cliente.", ex);
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String busqueda = request.getParameter("busqueda");
        List<Cliente> clientes = clienteDAO.listar(busqueda);
        request.setAttribute("clientes", clientes);
        request.setAttribute("busqueda", busqueda);
        request.getRequestDispatcher("/clientes/listar.jsp").forward(request, response);
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("cliente", new Cliente());
        request.getRequestDispatcher("/clientes/formulario.jsp").forward(request, response);
    }

    private void mostrarEditar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int idCliente = Validador.convertirEntero(request.getParameter("id"), 0);
        Cliente cliente = clienteDAO.obtenerPorId(idCliente);

        if (cliente == null) {
            response.sendRedirect(request.getContextPath() + "/clientes?error=no_encontrado");
            return;
        }

        request.setAttribute("cliente", cliente);
        request.getRequestDispatcher("/clientes/editar.jsp").forward(request, response);
    }

    private void registrar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Cliente cliente = leerCliente(request);
        String error = validar(cliente);

        if (error != null) {
            request.setAttribute("errorFormulario", error);
            request.setAttribute("cliente", cliente);
            request.getRequestDispatcher("/clientes/formulario.jsp").forward(request, response);
            return;
        }

        clienteDAO.registrar(cliente);
        response.sendRedirect(request.getContextPath() + "/clientes?mensaje=registrado");
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Cliente cliente = leerCliente(request);
        cliente.setIdCliente(Validador.convertirEntero(request.getParameter("idCliente"), 0));
        String error = validar(cliente);

        if (cliente.getIdCliente() <= 0) {
            error = "El cliente no es valido.";
        }

        if (error != null) {
            request.setAttribute("errorFormulario", error);
            request.setAttribute("cliente", cliente);
            request.getRequestDispatcher("/clientes/editar.jsp").forward(request, response);
            return;
        }

        clienteDAO.actualizar(cliente);
        response.sendRedirect(request.getContextPath() + "/clientes?mensaje=actualizado");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int idCliente = Validador.convertirEntero(request.getParameter("id"), 0);

        if (idCliente <= 0) {
            response.sendRedirect(request.getContextPath() + "/clientes?error=no_encontrado");
            return;
        }

        boolean eliminado = clienteDAO.eliminar(idCliente);
        if (eliminado) {
            response.sendRedirect(request.getContextPath() + "/clientes?mensaje=eliminado");
        } else {
            response.sendRedirect(request.getContextPath() + "/clientes?error=relacionado");
        }
    }

    private Cliente leerCliente(HttpServletRequest request) {
        Cliente cliente = new Cliente();
        cliente.setTipoDocumento(request.getParameter("tipoDocumento"));
        cliente.setNumeroDocumento(request.getParameter("numeroDocumento"));
        cliente.setNombres(request.getParameter("nombres"));
        cliente.setApellidos(request.getParameter("apellidos"));
        cliente.setRazonSocial(request.getParameter("razonSocial"));
        cliente.setTelefono(request.getParameter("telefono"));
        cliente.setCorreo(request.getParameter("correo"));
        cliente.setDireccion(request.getParameter("direccion"));
        cliente.setEstado("1".equals(request.getParameter("estado")));
        return cliente;
    }

    private String validar(Cliente cliente) {
        if (Validador.estaVacio(cliente.getTipoDocumento())) {
            return "El tipo de documento es obligatorio.";
        }
        if (Validador.estaVacio(cliente.getNumeroDocumento())) {
            return "El numero de documento es obligatorio.";
        }
        if ("RUC".equals(cliente.getTipoDocumento()) && Validador.estaVacio(cliente.getRazonSocial())) {
            return "La razon social es obligatoria para clientes con RUC.";
        }
        if ("DNI".equals(cliente.getTipoDocumento())
                && (Validador.estaVacio(cliente.getNombres()) || Validador.estaVacio(cliente.getApellidos()))) {
            return "Los nombres y apellidos son obligatorios para clientes con DNI.";
        }
        return null;
    }
}
