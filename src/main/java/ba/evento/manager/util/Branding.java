package ba.evento.manager.util;

import javafx.scene.image.Image;
import javafx.scene.image.ImageView;

import java.net.URL;

public final class Branding {

    private Branding() {
    }

    public static ImageView logo(double width) {
        URL url = Branding.class.getResource("/images/logo.png");
        if (url == null) {
            return null;
        }
        ImageView view = new ImageView(new Image(url.toExternalForm()));
        view.setFitWidth(width);
        view.setPreserveRatio(true);
        view.setSmooth(true);
        return view;
    }
}
