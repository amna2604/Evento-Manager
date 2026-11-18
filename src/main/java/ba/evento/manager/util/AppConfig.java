package ba.evento.manager.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Properties;

public final class AppConfig {

    private static final Properties PROPS = load();

    private AppConfig() {
    }

    private static Properties load() {
        Properties props = new Properties();
        try (InputStream in = AppConfig.class.getResourceAsStream("/db.properties")) {
            if (in != null) {
                props.load(new InputStreamReader(in, StandardCharsets.UTF_8));
            }
        } catch (IOException e) {
            throw new IllegalStateException("Ne mogu ucitati db.properties", e);
        }
        Path external = AppPaths.dataDir().resolve("db.properties");
        if (Files.exists(external)) {
            try (Reader reader = Files.newBufferedReader(external, StandardCharsets.UTF_8)) {
                props.load(reader);
            } catch (IOException e) {
                throw new IllegalStateException("Ne mogu ucitati " + external, e);
            }
        }
        return props;
    }

    public static String dbUrl() {
        String url = fromEnv("EVENTO_DB_URL", PROPS.getProperty("db.url"));
        if (!url.contains("createDatabaseIfNotExist")) {
            url += (url.contains("?") ? "&" : "?") + "createDatabaseIfNotExist=true";
        }
        return url;
    }




    public static String dbUser() {
        return fromEnv("EVENTO_DB_USER", PROPS.getProperty("db.user", "root"));
    }

    public static String dbPassword() {
        return fromEnv("EVENTO_DB_PASSWORD", PROPS.getProperty("db.password", ""));
    }


    public static BigDecimal defaultAllowance() {
        return new BigDecimal(PROPS.getProperty("allowance.default", "40.00"));
    }


    private static String fromEnv(String name, String fallback) {
        String value = System.getenv(name);
        return value != null && !value.isBlank() ? value : fallback;
    }






}
