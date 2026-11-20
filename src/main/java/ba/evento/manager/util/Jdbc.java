package ba.evento.manager.util;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public final class Jdbc {

    @FunctionalInterface
    public interface RowMapper<T> {
        T map(ResultSet rs) throws SQLException;
    }

    private Jdbc() {
    }

    public static <T> List<T> query(String sql, RowMapper<T> mapper, Object... params) {
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            bind(ps, params);
            try (ResultSet rs = ps.executeQuery()) {
                List<T> result = new ArrayList<>();
                while (rs.next()) {
                    result.add(mapper.map(rs));
                }
                return result;
            }
        } catch (SQLException e) {
            throw new DataAccessException("Greška pri čitanju iz baze", e);
        }
    }

    public static <T> Optional<T> queryOne(String sql, RowMapper<T> mapper, Object... params) {
        return query(sql, mapper, params).stream().findFirst();
    }

    public static int count(String sql, Object... params) {
        return queryOne(sql, rs -> rs.getInt(1), params).orElse(0);
    }

    /** Izvrsava INSERT i vraca generisani id. */
    public static long insert(String sql, Object... params) {
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            bind(ps, params);
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                return keys.next() ? keys.getLong(1) : 0;
            }
        } catch (SQLException e) {
            throw new DataAccessException("Greška pri upisu u bazu", e);
        }
    }

    public static int update(String sql, Object... params) {
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            bind(ps, params);
            return ps.executeUpdate();
        } catch (SQLException e) {
            throw new DataAccessException("Greška pri izmjeni podataka u bazi", e);
        }
    }

    @FunctionalInterface
    public interface TransactionWork {
        void run(Connection con) throws SQLException;
    }

    /** Izvrsava vise naredbi kao jednu cjelinu: ili prodju sve ili nijedna. */
    public static void inTransaction(TransactionWork work) {
        try (Connection con = Database.getConnection()) {
            con.setAutoCommit(false);
            try {
                work.run(con);
                con.commit();
            } catch (SQLException | RuntimeException e) {
                con.rollback();
                throw e;
            }
        } catch (SQLException e) {
            throw new DataAccessException("Greška pri izvršavanju transakcije", e);
        }
    }

    public static int update(Connection con, String sql, Object... params) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            bind(ps, params);
            return ps.executeUpdate();
        }
    }

    private static void bind(PreparedStatement ps, Object[] params) throws SQLException {
        for (int i = 0; i < params.length; i++) {
            Object p = params[i];
            if (p instanceof Enum<?> e) {
                p = e.name();
            } else if (p instanceof LocalDate d) {
                p = Date.valueOf(d);
            } else if (p instanceof LocalDateTime dt) {
                p = Timestamp.valueOf(dt);
            }
            ps.setObject(i + 1, p);
        }
    }

    public static LocalDate date(ResultSet rs, String column) throws SQLException {
        Date value = rs.getDate(column);
        return value == null ? null : value.toLocalDate();
    }

    public static LocalDateTime dateTime(ResultSet rs, String column) throws SQLException {
        Timestamp value = rs.getTimestamp(column);
        return value == null ? null : value.toLocalDateTime();
    }

    public static Long nullableLong(ResultSet rs, String column) throws SQLException {
        long value = rs.getLong(column);
        return rs.wasNull() ? null : value;
    }
}
