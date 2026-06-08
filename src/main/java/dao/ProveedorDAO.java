package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.Proveedor;

public class ProveedorDAO {

    public List<Proveedor> listar(String busqueda) throws SQLException {
        List<Proveedor> proveedores = new ArrayList<>();
        String sql = "SELECT id_proveedor, razon_social, ruc, telefono, correo, direccion, estado "
                + "FROM proveedor "
                + "WHERE (? IS NULL OR razon_social LIKE ? OR ruc LIKE ?) "
                + "ORDER BY id_proveedor DESC";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            String filtro = prepararFiltro(busqueda);
            ps.setString(1, filtro);
            ps.setString(2, filtro);
            ps.setString(3, filtro);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    proveedores.add(mapear(rs));
                }
            }
        }

        return proveedores;
    }

    public Proveedor obtenerPorId(int idProveedor) throws SQLException {
        String sql = "SELECT id_proveedor, razon_social, ruc, telefono, correo, direccion, estado "
                + "FROM proveedor WHERE id_proveedor = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idProveedor);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
            }
        }

        return null;
    }

    public void registrar(Proveedor proveedor) throws SQLException {
        String sql = "INSERT INTO proveedor (razon_social, ruc, telefono, correo, direccion, estado) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, proveedor.getRazonSocial());
            ps.setString(2, proveedor.getRuc());
            ps.setString(3, proveedor.getTelefono());
            ps.setString(4, proveedor.getCorreo());
            ps.setString(5, proveedor.getDireccion());
            ps.setBoolean(6, proveedor.isEstado());
            ps.executeUpdate();
        }
    }

    public void actualizar(Proveedor proveedor) throws SQLException {
        String sql = "UPDATE proveedor SET razon_social = ?, ruc = ?, telefono = ?, correo = ?, "
                + "direccion = ?, estado = ? WHERE id_proveedor = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, proveedor.getRazonSocial());
            ps.setString(2, proveedor.getRuc());
            ps.setString(3, proveedor.getTelefono());
            ps.setString(4, proveedor.getCorreo());
            ps.setString(5, proveedor.getDireccion());
            ps.setBoolean(6, proveedor.isEstado());
            ps.setInt(7, proveedor.getIdProveedor());
            ps.executeUpdate();
        }
    }

    public boolean eliminar(int idProveedor) throws SQLException {
        if (tieneProductosAsociados(idProveedor)) {
            return false;
        }

        String sql = "DELETE FROM proveedor WHERE id_proveedor = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idProveedor);
            return ps.executeUpdate() > 0;
        }
    }

    private boolean tieneProductosAsociados(int idProveedor) throws SQLException {
        String sql = "SELECT COUNT(*) FROM producto WHERE id_proveedor = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idProveedor);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private Proveedor mapear(ResultSet rs) throws SQLException {
        Proveedor proveedor = new Proveedor();
        proveedor.setIdProveedor(rs.getInt("id_proveedor"));
        proveedor.setRazonSocial(rs.getString("razon_social"));
        proveedor.setRuc(rs.getString("ruc"));
        proveedor.setTelefono(rs.getString("telefono"));
        proveedor.setCorreo(rs.getString("correo"));
        proveedor.setDireccion(rs.getString("direccion"));
        proveedor.setEstado(rs.getBoolean("estado"));
        return proveedor;
    }

    private String prepararFiltro(String busqueda) {
        if (busqueda == null || busqueda.trim().isEmpty()) {
            return null;
        }
        return "%" + busqueda.trim() + "%";
    }
}
