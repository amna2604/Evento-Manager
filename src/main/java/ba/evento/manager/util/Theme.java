package ba.evento.manager.util;

import javafx.scene.Parent;

import java.util.prefs.Preferences;

/** Svijetla i tamna tema; izbor se pamti izmedju pokretanja aplikacije. */
public final class Theme {

    private static final String STYLESHEET = "/css/style.css";
    private static final String KEY = "theme";
    private static final Preferences PREFS = Preferences.userNodeForPackage(Theme.class);

    private Theme() {
    }

    public static boolean isDark() {
        return "dark".equals(PREFS.get(KEY, "dark"));
    }

    public static void setDark(boolean dark) {
        PREFS.put(KEY, dark ? "dark" : "light");
    }

    /** Dodaje stylesheet i klasu teme na korijenski element scene ili dijaloga. */
    public static void apply(Parent root) {
        String css = Theme.class.getResource(STYLESHEET).toExternalForm();
        if (!root.getStylesheets().contains(css)) {
            root.getStylesheets().add(css);
        }
        root.getStyleClass().remove("dark");
        if (isDark()) {
            root.getStyleClass().add("dark");
        }
    }
}
