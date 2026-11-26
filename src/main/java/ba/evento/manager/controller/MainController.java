package ba.evento.manager.controller;

import ba.evento.manager.Main;
import ba.evento.manager.model.User;
import ba.evento.manager.service.Session;
import ba.evento.manager.util.Branding;
import ba.evento.manager.util.Dialogs;
import ba.evento.manager.util.Icons;
import ba.evento.manager.util.ViewLoader;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.Toggle;
import javafx.scene.control.ToggleButton;
import javafx.scene.control.ToggleGroup;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import javafx.stage.Window;

import java.util.LinkedHashMap;
import java.util.Map;


public class MainController {

    @FXML
    private BorderPane root;
    @FXML
    private StackPane content;
    @FXML
    private HBox brandBox;
    @FXML
    private Label pageTitle;
    @FXML
    private Label userName;
    @FXML
    private Label userRole;
    @FXML
    private Label avatar;
    @FXML
    private Button logoutButton;
    @FXML
    private ToggleGroup navGroup;
    @FXML
    private ToggleButton navHome;
    @FXML
    private ToggleButton navPromotions;
    @FXML
    private ToggleButton navPromoters;
    @FXML
    private ToggleButton navStock;
    @FXML
    private ToggleButton navReports;
    @FXML
    private ToggleButton navSettings;


    private final Map<Toggle, Navigator.View> views = new LinkedHashMap<>();
    private Navigator.View current;

    @FXML
    private void initialize() {
        Navigator.register(this);

        views.put(navHome, Navigator.View.HOME);
        views.put(navPromotions, Navigator.View.PROMOTIONS);
        views.put(navPromoters, Navigator.View.PROMOTERS);
        views.put(navStock, Navigator.View.STOCK);
        views.put(navReports, Navigator.View.REPORTS);
        views.put(navSettings, Navigator.View.SETTINGS);

        navHome.setGraphic(Icons.of("home", 19));
        navPromotions.setGraphic(Icons.of("calendar", 19));
        navPromoters.setGraphic(Icons.of("people", 19));
        navStock.setGraphic(Icons.of("box", 19));
        navReports.setGraphic(Icons.of("chart", 19));
        navSettings.setGraphic(Icons.of("sliders", 19));
        logoutButton.setGraphic(Icons.of("logout", 17));

        showBrand();

        User user = Session.user();
        userName.setText(user.fullName());
        userRole.setText(user.role().label() + (user.cityName() != null ? " · " + user.cityName() : ""));
        avatar.setText(initials(user.fullName()));

        navGroup.selectedToggleProperty().addListener((obs, old, now) -> {
            if (now == null) {
                // klik na vec izabranu stavku ne smije ostaviti navigaciju bez izbora
                old.setSelected(true);
            } else {
                load(views.get(now));
            }
        });
        navHome.setSelected(true);
    }


    void show(Navigator.View view) {
        Toggle toggle = views.entrySet().stream()
                .filter(e -> e.getValue() == view).map(Map.Entry::getKey).findFirst().orElseThrow();
        if (toggle.isSelected()) {
            load(view);
        } else {
            toggle.setSelected(true);
        }
    }


    private void load(Navigator.View view) {
        current = view;
        pageTitle.setText(view.title());
        if (MainController.class.getResource("/view/" + view.fxml() + ".fxml") == null) {
            Label soon = new Label("Ekran \"" + view.title() + "\" je u izradi.");
            soon.getStyleClass().add("muted");
            content.getChildren().setAll(soon);
            return;
        }
        Dialogs.run(window(), () -> {
            ViewLoader.Loaded<?> loaded = ViewLoader.load(view.fxml());
            content.getChildren().setAll(loaded.root());
        });
    }

    void reloadCurrent() {
        show(current);
    }

    Window window() {
        return Main.stage();
    }

    @FXML
    private void onLogout() {
        Main.showLogin();
    }


    private void showBrand() {
        var logo = Branding.logo(176);
        if (logo != null) {
            brandBox.getChildren().add(logo);
            return;
        }
        Label star = new Label();
        star.setGraphic(Icons.of("star", 26));
        star.getStyleClass().add("brand-mark");
        Label name1 = new Label("EVENTO");
        name1.getStyleClass().add("brand-name");
        Label name2 = new Label("MANAGER");
        name2.getStyleClass().add("brand-name-light");
        brandBox.getChildren().addAll(star, new VBox(-2, name1, name2));
    }


    private static String initials(String fullName) {
        StringBuilder sb = new StringBuilder();
        for (String part : fullName.trim().split("\\s+")) {
            if (!part.isEmpty() && sb.length() < 2) {
                sb.append(Character.toUpperCase(part.charAt(0)));
            }
        }
        return sb.toString();
    }
}