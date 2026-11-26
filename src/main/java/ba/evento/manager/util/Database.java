package ba.evento.manager.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import java.sql.ResultSet;


public final class Database {

    static final String DEMO_HASH_PLACEHOLDER = "NIJE-POSTAVLJENO";
    private Database() {
    }


    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(AppConfig.dbUrl(), AppConfig.dbUser(), AppConfig.dbPassword());
    }
    public static void initialize() {
        try (Connection con = getConnection()) {
            runScript(con, "/db/schema.sql", null);
            if (countUsers(con) == 0) {
                runScript(con, "/db/seed.sql", PasswordHasher.hash("evento123"));
            }
        } catch (SQLException e) {
            throw new DataAccessException("Nije moguće povezati se s bazom (" + AppConfig.dbUrl() + ")", e);
        }
    }



    private static int countUsers(Connection con) throws SQLException {
        try (Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM users")) {
            rs.next();
            return rs.getInt(1);
        }
    }


    private static void runScript(Connection con, String resource, String demoHash) throws SQLException {
        for (String statement : readStatements(resource))
        {
            String sql = demoHash == null ? statement : statement.replace("{{DEMO_HASH}}", demoHash);
            try (Statement st = con.createStatement()) {
                st.execute(sql);
            }
        }
    }




    static List<String> readStatements(String resource) {
        List<String> statements = new ArrayList<>();
        try (InputStream in = Database.class.getResourceAsStream(resource)) {
            if (in == null) {
                throw new IllegalStateException("Nedostaje resurs " + resource);
            }


            BufferedReader reader = new BufferedReader(new InputStreamReader(in, StandardCharsets.UTF_8));
            StringBuilder current = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                String trimmed = line.trim();
                if (trimmed.isEmpty() || trimmed.startsWith("--")) {
                    continue;
                }
                current.append(line).append('\n');
                if (trimmed.endsWith(";")) {
                    String sql = current.toString().trim();
                    statements.add(sql.substring(0, sql.length() - 1));
                    current.setLength(0);
                }

            }


        } catch (IOException e) {

            throw new IllegalStateException("Ne mogu pročitati " + resource, e);
        }
        return statements;
    }
}