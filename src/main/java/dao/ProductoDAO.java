package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.Producto;

public class ProductoDAO {

    public List<Producto> listar(String busqueda) throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String sql = consultaBase()
                + "WHERE (? IS NULL OR p.codigo_producto LIKE ? OR p.nombre_producto LIKE ? "
                + "OR c.nombre LIKE ? OR pr.razon_social LIKE ?) "
                + "ORDER BY p.id_producto DESC";

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
                    productos.add(mapear(rs));
                }
            }
        }

        return productos;
    }

    public List<Producto> listarBajoStock() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String sql = consultaBase()
                + "WHERE p.stock <= p.stock_minimo "
                + "ORDER BY p.stock ASC, p.nombre_producto ASC";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                productos.add(mapear(rs));
            }
        }

        return productos;
    }

    public Producto obtenerPorId(int idProducto) throws SQLException {
        String sql = consultaBase() + "WHERE p.id_producto = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idProducto);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
            }
        }

        return null;
    }

    public void registrar(Producto producto) throws SQLException {
        String sql = "INSERT INTO producto (codigo_producto, nombre_producto, descripcion, id_categoria, "
                + "id_proveedor, unidad_medida, precio_compra, precio_venta, stock, stock_minimo, estado) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            asignarParametros(ps, producto);
            ps.executeUpdate();
        }
    }

    public void actualizar(Producto producto) throws SQLException {
        String sql = "UPDATE producto SET codigo_producto = ?, nombre_producto = ?, descripcion = ?, "
                + "id_categoria = ?, id_proveedor = ?, unidad_medida = ?, precio_compra = ?, "
                + "precio_venta = ?, stock = ?, stock_minimo = ?, estado = ? WHERE id_producto = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            asignarParametros(ps, producto);
            ps.setInt(12, producto.getIdProducto());
            ps.executeUpdate();
        }
    }

    public boolean eliminar(int idProducto) throws SQLException {
        if (tieneVentasAsociadas(idProducto)) {
            return false;
        }

        String sql = "DELETE FROM producto WHERE id_producto = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idProducto);
            return ps.executeUpdate() > 0;
        }
    }

    private boolean tieneVentasAsociadas(int idProducto) throws SQLException {
        String sql = "SELECT COUNT(*) FROM detalle_venta WHERE id_producto = ?";

        try (Connection cn = Conexion.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idProducto);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private void asignarParametros(PreparedStatement ps, Producto producto) throws SQLException {
        ps.setString(1, producto.getCodigoProducto());
        ps.setString(2, producto.getNombreProducto());
        ps.setString(3, producto.getDescripcion());
        ps.setInt(4, producto.getIdCategoria());
        ps.setInt(5, producto.getIdProveedor());
        ps.setString(6, producto.getUnidadMedida());
        ps.setBigDecimal(7, producto.getPrecioCompra());
        ps.setBigDecimal(8, producto.getPrecioVenta());
        ps.setInt(9, producto.getStock());
        ps.setInt(10, producto.getStockMinimo());
        ps.setBoolean(11, producto.isEstado());
    }

    private Producto mapear(ResultSet rs) throws SQLException {
        Producto producto = new Producto();
        producto.setIdProducto(rs.getInt("id_producto"));
        producto.setCodigoProducto(rs.getString("codigo_producto"));
        producto.setNombreProducto(rs.getString("nombre_producto"));
        producto.setDescripcion(rs.getString("descripcion"));
        producto.setIdCategoria(rs.getInt("id_categoria"));
        producto.setIdProveedor(rs.getInt("id_proveedor"));
        producto.setUnidadMedida(rs.getString("unidad_medida"));
        producto.setPrecioCompra(rs.getBigDecimal("precio_compra"));
        producto.setPrecioVenta(rs.getBigDecimal("precio_venta"));
        producto.setStock(rs.getInt("stock"));
        producto.setStockMinimo(rs.getInt("stock_minimo"));
        producto.setEstado(rs.getBoolean("estado"));
        producto.setNombreCategoria(rs.getString("nombre_categoria"));
        producto.setRazonSocialProveedor(rs.getString("razon_social_proveedor"));
        return producto;
    }

    private String consultaBase() {
        return "SELECT p.id_producto, p.codigo_producto, p.nombre_producto, p.descripcion, "
                + "p.id_categoria, p.id_proveedor, p.unidad_medida, p.precio_compra, "
                + "p.precio_venta, p.stock, p.stock_minimo, p.estado, "
                + "c.nombre AS nombre_categoria, pr.razon_social AS razon_social_proveedor "
                + "FROM producto p "
                + "INNER JOIN categoria c ON c.id_categoria = p.id_categoria "
                + "INNER JOIN proveedor pr ON pr.id_proveedor = p.id_proveedor ";
    }

    private String prepararFiltro(String busqueda) {
        if (busqueda == null || busqueda.trim().isEmpty()) {
            return null;
        }
        return "%" + busqueda.trim() + "%";
    }
}
