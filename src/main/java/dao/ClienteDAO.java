package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.Cliente;

public class ClienteDAO {

    public List<Cliente> listar(String busqueda) throws SQLException {
        List<Cliente> clientes = new ArrayList<>();
        String sql = "SELECT id_cliente, tipo_documento, numero_documento, nombres, apellidos, "
                + "razon_social, telefono, correo, direccion, estado FROM cliente "
                + "WHERE (? IS NULL OR numero_documento LIKE ? OR nombres LIKE ? OR apellidos LIKE ? OR razon_social LIKE ?) "
                + "ORDER BY id_cliente DESC";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            String filtro = prepararFiltro(busqueda);
            ps.setString(1, filtro);
            ps.setString(2, filtro);
            ps.setString(3, filtro);
            ps.setString(4, filtro);
            ps.setString(5, filtro);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    clientes.add(mapear(rs));
                }
            }
        }

        return clientes;
    }

    public Cliente obtenerPorId(int idCliente) throws SQLException {
        String sql = "SELECT id_cliente, tipo_documento, numero_documento, nombres, apellidos, "
                + "razon_social, telefono, correo, direccion, estado FROM cliente WHERE id_cliente = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idCliente);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
            }
        }

        return null;
    }

    public void registrar(Cliente cliente) throws SQLException {
        String sql = "INSERT INTO cliente (tipo_documento, numero_documento, nombres, apellidos, "
                + "razon_social, telefono, correo, direccion, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            asignarParametros(ps, cliente);
            ps.executeUpdate();
        }
    }

    public void actualizar(Cliente cliente) throws SQLException {
        String sql = "UPDATE cliente SET tipo_documento = ?, numero_documento = ?, nombres = ?, "
                + "apellidos = ?, razon_social = ?, telefono = ?, correo = ?, direccion = ?, estado = ? "
                + "WHERE id_cliente = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            asignarParametros(ps, cliente);
            ps.setInt(10, cliente.getIdCliente());
            ps.executeUpdate();
        }
    }

    public boolean eliminar(int idCliente) throws SQLException {
        if (tieneVentasAsociadas(idCliente)) {
            return false;
        }

        String sql = "DELETE FROM cliente WHERE id_cliente = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idCliente);
            return ps.executeUpdate() > 0;
        }
    }

    private boolean tieneVentasAsociadas(int idCliente) throws SQLException {
        String sql = "SELECT COUNT(*) FROM venta WHERE id_cliente = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idCliente);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private void asignarParametros(PreparedStatement ps, Cliente cliente) throws SQLException {
        ps.setString(1, cliente.getTipoDocumento());
        ps.setString(2, cliente.getNumeroDocumento());
        ps.setString(3, cliente.getNombres());
        ps.setString(4, cliente.getApellidos());
        ps.setString(5, cliente.getRazonSocial());
        ps.setString(6, cliente.getTelefono());
        ps.setString(7, cliente.getCorreo());
        ps.setString(8, cliente.getDireccion());
        ps.setBoolean(9, cliente.isEstado());
    }

    private Cliente mapear(ResultSet rs) throws SQLException {
        Cliente cliente = new Cliente();
        cliente.setIdCliente(rs.getInt("id_cliente"));
        cliente.setTipoDocumento(rs.getString("tipo_documento"));
        cliente.setNumeroDocumento(rs.getString("numero_documento"));
        cliente.setNombres(rs.getString("nombres"));
        cliente.setApellidos(rs.getString("apellidos"));
        cliente.setRazonSocial(rs.getString("razon_social"));
        cliente.setTelefono(rs.getString("telefono"));
        cliente.setCorreo(rs.getString("correo"));
        cliente.setDireccion(rs.getString("direccion"));
        cliente.setEstado(rs.getBoolean("estado"));
        return cliente;
    }

    private String prepararFiltro(String busqueda) {
        if (busqueda == null || busqueda.trim().isEmpty()) {
            return null;
        }
        return "%" + busqueda.trim() + "%";
    }
}
