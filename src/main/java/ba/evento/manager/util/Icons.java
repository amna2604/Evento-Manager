package ba.evento.manager.util;

import javafx.scene.layout.StackPane;
import javafx.scene.shape.SVGPath;

import java.util.Map;

public final class Icons {

    private static final Map<String, String> PATHS = Map.ofEntries(
            Map.entry("home", "M3 11.5 12 4l9 7.5 M5.5 10v10h13V10 M10 20v-6h4v6"),
            Map.entry("calendar", "M4 6h16v14H4z M4 10.5h16 M8 3v4 M16 3v4"),
            Map.entry("people", "M9 11a3 3 0 1 0 0-6 3 3 0 0 0 0 6z M3 20c0-3.3 2.7-6 6-6s6 2.7 6 6 "
                    + "M16.5 11a2.5 2.5 0 1 0 0-5 M17 14.2c2.4.5 4 2.4 4 5.8"),
            Map.entry("box", "M3 8l9-5 9 5v8l-9 5-9-5z M3 8l9 5 9-5 M12 13v8"),
            Map.entry("chart", "M4 20V4 M4 20h16 M8 16v-5 M12 16V8 M16 16v-3"),
            Map.entry("sliders", "M4 7h10 M18 7h2 M4 17h2 M10 17h10 M16 4v6 M8 14v6"),
            Map.entry("bell", "M6 16v-5a6 6 0 0 1 12 0v5l2 2H4z M10 21h4"),
            Map.entry("logout", "M10 4H5v16h5 M14 8l4 4-4 4 M18 12H9"),
            Map.entry("check", "M12 3.5a8.5 8.5 0 1 0 0 17 8.5 8.5 0 0 0 0-17z M8 12.3l2.8 2.8L16 9.6"),
            Map.entry("clock", "M12 3.5a8.5 8.5 0 1 0 0 17 8.5 8.5 0 0 0 0-17z M12 7.5V12l3 2"),
            Map.entry("cross", "M12 3.5a8.5 8.5 0 1 0 0 17 8.5 8.5 0 0 0 0-17z M9 9l6 6 M15 9l-6 6"),
            Map.entry("gift", "M4 10h16v10H4z M3 7h18v3H3z M12 7v13 M12 7c-1-3-5-3.5-5-1.5S10 7 12 7z "
                    + "M12 7c1-3 5-3.5 5-1.5S14 7 12 7z"),
            Map.entry("target", "M12 3.5a8.5 8.5 0 1 0 0 17 8.5 8.5 0 0 0 0-17z M12 8a4 4 0 1 0 0 8 4 4 0 0 0 0-8z "
                    + "M12 11.5v1"),
            Map.entry("camera", "M3 8h4l2-3h6l2 3h4v12H3z M12 10a3.5 3.5 0 1 0 0 7 3.5 3.5 0 0 0 0-7z"),
            Map.entry("plus", "M12 5v14 M5 12h14"),
            Map.entry("file", "M6 3h8l4 4v14H6z M14 3v4h4 M9 12h6 M9 16h6"),
            Map.entry("star", "M12 3l2.6 5.6 6.1.7-4.5 4.2 1.2 6L12 16.5 6.6 19.5l1.2-6L3.3 9.3l6.1-.7z"),
            Map.entry("bolt", "M13 3 5 13h6l-1 8 8-10h-6z"),
            Map.entry("arrow", "M5 12h14 M13 6l6 6-6 6"),
            Map.entry("chevron", "M9 6l6 6-6 6"),
            Map.entry("pin", "M12 21s-6-5.3-6-10a6 6 0 1 1 12 0c0 4.7-6 10-6 10z M12 8.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5z"),
            Map.entry("user", "M12 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8z M4 21c0-4.4 3.6-8 8-8s8 3.6 8 8"));

    private Icons() {
    }

    public static StackPane of(String name, double size) {
        String content = PATHS.get(name);
        if (content == null) {
            throw new IllegalArgumentException("Nepoznata ikona: " + name);
        }
        SVGPath path = new SVGPath();
        path.setContent(content);
        path.getStyleClass().add("icon");
        double scale = size / 24.0;
        path.setScaleX(scale);
        path.setScaleY(scale);
        StackPane box = new StackPane(path);
        box.setMinSize(size, size);
        box.setPrefSize(size, size);
        box.setMaxSize(size, size);
        return box;
    }
}
