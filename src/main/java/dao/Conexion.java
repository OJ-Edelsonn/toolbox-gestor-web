package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static final String URL = "jdbc:mysql://localhost:3306/bd_toolbox_gestor_web?useSSL=false&serverTimezone=America/Lima&allowPublicKeyRetrieval=true";
    private static final String USUARIO = "root";
    private static final String CLAVE = "";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    private Conexion() {
    }

    public static Connection obtenerConexion() throws SQLException {
        try {
            Class.forName(DRIVER);
            return DriverManager.getConnection(URL, USUARIO, CLAVE);
        } catch (ClassNotFoundException ex) {
            throw new SQLException("No se encontro el driver JDBC de MySQL.", ex);
        }
    }
}
