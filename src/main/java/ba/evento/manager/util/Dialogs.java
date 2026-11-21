package ba.evento.manager.util;

import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.TextInputDialog;
import javafx.stage.Window;

import java.util.Optional;

/** Standardni dijalozi (poruke, potvrde, unos teksta) sa temom aplikacije. */
public final class Dialogs {

    private Dialogs() {
    }

    public static void info(Window owner, String title, String message) {
        show(owner, Alert.AlertType.INFORMATION, title, message);
    }

    public static void error(Window owner, String message) {
        show(owner, Alert.AlertType.ERROR, "Greška", message);
    }

    public static void warning(Window owner, String message) {
        show(owner, Alert.AlertType.WARNING, "Upozorenje", message);
    }

    public static boolean confirm(Window owner, String title, String message) {
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION, message, ButtonType.OK, ButtonType.CANCEL);
        prepare(alert, owner, title);
        return alert.showAndWait().filter(b -> b == ButtonType.OK).isPresent();
    }

    public static Optional<String> prompt(Window owner, String title, String message, String initial) {
        TextInputDialog dialog = new TextInputDialog(initial);
        dialog.setTitle(title);
        dialog.setHeaderText(null);
        dialog.setContentText(message);
        if (owner != null) {
            dialog.initOwner(owner);
        }
        Theme.apply(dialog.getDialogPane());
        return dialog.showAndWait();
    }

    /**
     * Izvrsava akciju i greske prikazuje korisniku umjesto da ih "proguta" konzola.
     * IllegalArgumentException nosi poruku za korisnika (npr. neispravan unos).
     */
    public static void run(Window owner, Runnable action) {
        try {
            action.run();
        } catch (IllegalArgumentException e) {
            warning(owner, e.getMessage());
        } catch (DataAccessException e) {
            error(owner, e.getMessage() + causeText(e));
        } catch (RuntimeException e) {
            e.printStackTrace();
            error(owner, "Došlo je do neočekivane greške: " + e.getMessage());
        }
    }

    private static String causeText(Throwable e) {
        Throwable cause = e.getCause();
        return cause == null || cause.getMessage() == null ? "" : "\n(" + cause.getMessage() + ")";
    }

    private static void show(Window owner, Alert.AlertType type, String title, String message) {
        Alert alert = new Alert(type, message, ButtonType.OK);
        prepare(alert, owner, title);
        alert.showAndWait();
    }

    private static void prepare(Alert alert, Window owner, String title) {
        alert.setTitle(title);
        alert.setHeaderText(null);
        if (owner != null) {
            alert.initOwner(owner);
        }
        Theme.apply(alert.getDialogPane());
    }
}
