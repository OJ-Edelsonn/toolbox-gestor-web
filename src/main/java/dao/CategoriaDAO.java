package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.Categoria;

public class CategoriaDAO {

    public List<Categoria> listar(String busqueda) throws SQLException {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT id_categoria, nombre, descripcion, estado FROM categoria "
                + "WHERE (? IS NULL OR nombre LIKE ?) ORDER BY id_categoria DESC";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            String filtro = prepararFiltro(busqueda);
            ps.setString(1, filtro);
            ps.setString(2, filtro);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    categorias.add(mapear(rs));
                }
            }
        }

        return categorias;
    }

    public Categoria obtenerPorId(int idCategoria) throws SQLException {
        String sql = "SELECT id_categoria, nombre, descripcion, estado FROM categoria WHERE id_categoria = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idCategoria);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
            }
        }

        return null;
    }

    public void registrar(Categoria categoria) throws SQLException {
        String sql = "INSERT INTO categoria (nombre, descripcion, estado) VALUES (?, ?, ?)";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, categoria.getNombre());
            ps.setString(2, categoria.getDescripcion());
            ps.setBoolean(3, categoria.isEstado());
            ps.executeUpdate();
        }
    }

    public void actualizar(Categoria categoria) throws SQLException {
        String sql = "UPDATE categoria SET nombre = ?, descripcion = ?, estado = ? WHERE id_categoria = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, categoria.getNombre());
            ps.setString(2, categoria.getDescripcion());
            ps.setBoolean(3, categoria.isEstado());
            ps.setInt(4, categoria.getIdCategoria());
            ps.executeUpdate();
        }
    }

    public boolean eliminar(int idCategoria) throws SQLException {
        if (tieneProductosAsociados(idCategoria)) {
            return false;
        }

        String sql = "DELETE FROM categoria WHERE id_categoria = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idCategoria);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean tieneProductosAsociados(int idCategoria) throws SQLException {
        String sql = "SELECT COUNT(*) FROM producto WHERE id_categoria = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idCategoria);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private Categoria mapear(ResultSet rs) throws SQLException {
        Categoria categoria = new Categoria();
        categoria.setIdCategoria(rs.getInt("id_categoria"));
        categoria.setNombre(rs.getString("nombre"));
        categoria.setDescripcion(rs.getString("descripcion"));
        categoria.setEstado(rs.getBoolean("estado"));
        return categoria;
    }

    private String prepararFiltro(String busqueda) {
        if (busqueda == null || busqueda.trim().isEmpty()) {
            return null;
        }
        return "%" + busqueda.trim() + "%";
    }
}
