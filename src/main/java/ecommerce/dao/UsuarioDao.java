package ecommerce.dao;

import ecommerce.database.Database;
import ecommerce.models.Usuario;


import java.sql.*;
import java.time.LocalDateTime;

public class UsuarioDao {

    public int create(Usuario usuario) throws SQLException {

        String sql = "INSERT INTO usuarios (nombre, apellido, email, password, rol, telefono, fecha_registro, activo) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, usuario.getNombre());
            stmt.setString(2, usuario.getApellido());
            stmt.setString(3, usuario.getEmail());
            stmt.setString(4, usuario.getPassword());
            stmt.setString(5, usuario.getRol());
            stmt.setString(6, usuario.getTelefono());

            LocalDateTime fr = usuario.getFecharegistro() != null ? usuario.getFecharegistro() : LocalDateTime.now();
            stmt.setTimestamp(7, Timestamp.valueOf(fr));

            stmt.setBoolean(8, usuario.isActivo());

            stmt.executeUpdate();

            try (ResultSet keys = stmt.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);

                }
            }
        }
        return -1;
    }
}




