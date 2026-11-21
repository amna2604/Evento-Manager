package ba.evento.manager.util;

import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.net.URL;

public final class ViewLoader {

    public record Loaded<C>(Parent root, C controller) {
    }

    private ViewLoader() {
    }

    public static <C> Loaded<C> load(String viewName) {
        URL url = ViewLoader.class.getResource("/view/" + viewName + ".fxml");
        if (url == null) {
            throw new IllegalArgumentException("Nema ekrana " + viewName);
        }
        try {
            FXMLLoader loader = new FXMLLoader(url);
            Parent root = loader.load();
            return new Loaded<>(root, loader.getController());
        } catch (IOException e) {
            throw new UncheckedIOException("Ne mogu učitati ekran " + viewName, e);
        }
    }
}
