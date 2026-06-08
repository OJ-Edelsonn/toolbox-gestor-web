package controlador;

import dao.CategoriaDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Categoria;
import util.Validador;

@WebServlet(name = "CategoriaServlet", urlPatterns = {"/categorias"})
public class CategoriaServlet extends HttpServlet {

    private final CategoriaDAO categoriaDAO = new CategoriaDAO();

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
            throw new ServletException("Error al procesar categorias.", ex);
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
            throw new ServletException("Error al guardar categoria.", ex);
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String busqueda = request.getParameter("busqueda");
        List<Categoria> categorias = categoriaDAO.listar(busqueda);
        request.setAttribute("categorias", categorias);
        request.setAttribute("busqueda", busqueda);
        request.getRequestDispatcher("/categorias/listar.jsp").forward(request, response);
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("categoria", new Categoria());
        request.getRequestDispatcher("/categorias/formulario.jsp").forward(request, response);
    }

    private void mostrarEditar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int idCategoria = Validador.convertirEntero(request.getParameter("id"), 0);
        Categoria categoria = categoriaDAO.obtenerPorId(idCategoria);

        if (categoria == null) {
            response.sendRedirect(request.getContextPath() + "/categorias?error=no_encontrado");
            return;
        }

        request.setAttribute("categoria", categoria);
        request.getRequestDispatcher("/categorias/editar.jsp").forward(request, response);
    }

    private void registrar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Categoria categoria = leerCategoria(request);
        String error = validar(categoria);

        if (error != null) {
            request.setAttribute("errorFormulario", error);
            request.setAttribute("categoria", categoria);
            request.getRequestDispatcher("/categorias/formulario.jsp").forward(request, response);
            return;
        }

        categoriaDAO.registrar(categoria);
        response.sendRedirect(request.getContextPath() + "/categorias?mensaje=registrado");
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Categoria categoria = leerCategoria(request);
        categoria.setIdCategoria(Validador.convertirEntero(request.getParameter("idCategoria"), 0));
        String error = validar(categoria);

        if (categoria.getIdCategoria() <= 0) {
            error = "La categoria no es valida.";
        }

        if (error != null) {
            request.setAttribute("errorFormulario", error);
            request.setAttribute("categoria", categoria);
            request.getRequestDispatcher("/categorias/editar.jsp").forward(request, response);
            return;
        }

        categoriaDAO.actualizar(categoria);
        response.sendRedirect(request.getContextPath() + "/categorias?mensaje=actualizado");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int idCategoria = Validador.convertirEntero(request.getParameter("id"), 0);

        if (idCategoria <= 0) {
            response.sendRedirect(request.getContextPath() + "/categorias?error=no_encontrado");
            return;
        }

        boolean eliminado = categoriaDAO.eliminar(idCategoria);
        if (eliminado) {
            response.sendRedirect(request.getContextPath() + "/categorias?mensaje=eliminado");
        } else {
            response.sendRedirect(request.getContextPath() + "/categorias?error=relacionado");
        }
    }

    private Categoria leerCategoria(HttpServletRequest request) {
        Categoria categoria = new Categoria();
        categoria.setNombre(request.getParameter("nombre"));
        categoria.setDescripcion(request.getParameter("descripcion"));
        categoria.setEstado("1".equals(request.getParameter("estado")));
        return categoria;
    }

    private String validar(Categoria categoria) {
        if (Validador.estaVacio(categoria.getNombre())) {
            return "El nombre de la categoria es obligatorio.";
        }
        return null;
    }
}
