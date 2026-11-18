package ba.evento.manager.util;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.file.Files;
import java.nio.file.Path;

public final class AppPaths {


    private AppPaths() {
    }

    public static Path dataDir() {
        return ensure(Path.of(System.getProperty("user.home"), ".evento-manager"));
    }

    public static Path photosDir() {
        return ensure(dataDir().resolve("photos"));
    }

    public static Path backupDir() {
        return ensure(dataDir().resolve("backup"));
    }



    private static Path ensure(Path dir) {
        try {
            Files.createDirectories(dir);
            return dir;
        } catch (IOException e) {
            throw new UncheckedIOException("Ne mogu napraviti folder " + dir, e);
        }
    }






}
