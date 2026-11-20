package ba.evento.manager.dao;

import ba.evento.manager.model.Role;
import ba.evento.manager.model.User;
import ba.evento.manager.util.Jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public class UserDao {

    private static final String SELECT = """
            SELECT u.id, u.username, u.password_hash, u.full_name, u.role, u.city_id, u.active, c.name AS city_name
            FROM users u LEFT JOIN cities c ON c.id = u.city_id
            """;

    private static User map(ResultSet rs) throws SQLException {
        return new User(
                rs.getLong("id"),
                rs.getString("username"),
                rs.getString("password_hash"),
                rs.getString("full_name"),
                Role.valueOf(rs.getString("role")),
                Jdbc.nullableLong(rs, "city_id"),
                rs.getString("city_name"),
                rs.getBoolean("active"));
    }

    public int count() {
        return Jdbc.count("SELECT COUNT(*) FROM users");
    }

    public Optional<User> findByUsername(String username) {
        return Jdbc.queryOne(SELECT + " WHERE u.username = ?", UserDao::map, username);
    }

    public Optional<User> findById(long id) {
        return Jdbc.queryOne(SELECT + " WHERE u.id = ?", UserDao::map, id);
    }

    public List<User> findAll() {
        return Jdbc.query(SELECT + " ORDER BY u.full_name", UserDao::map);
    }

    /** Aktivni koordinatori za dati grad (za dodjelu promociji). */
    public List<User> findCoordinators(long cityId) {
        return Jdbc.query(SELECT + " WHERE u.role = ? AND u.city_id = ? AND u.active = 1 ORDER BY u.full_name",
                UserDao::map, Role.KOORDINATOR, cityId);
    }

    public long insert(String username, String passwordHash, String fullName, Role role, Long cityId) {
        return Jdbc.insert("""
                INSERT INTO users (username, password_hash, full_name, role, city_id)
                VALUES (?, ?, ?, ?, ?)""", username, passwordHash, fullName, role, cityId);
    }

    public void update(long id, String fullName, Role role, Long cityId, boolean active) {
        Jdbc.update("UPDATE users SET full_name = ?, role = ?, city_id = ?, active = ? WHERE id = ?",
                fullName, role, cityId, active, id);
    }

    public void updatePassword(long id, String passwordHash) {
        Jdbc.update("UPDATE users SET password_hash = ? WHERE id = ?", passwordHash, id);
    }
}
