package ba.evento.manager;

import ba.evento.manager.controller.LoginController;
import ba.evento.manager.service.Session;
import ba.evento.manager.util.AppConfig;
import ba.evento.manager.util.Database;
import ba.evento.manager.util.Dialogs;
import ba.evento.manager.util.Theme;
import ba.evento.manager.util.ViewLoader;
import javafx.application.Application;
import javafx.application.HostServices;
import javafx.application.Platform;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.nio.file.Path;

public class Main extends Application {

    private static Stage primaryStage;
    private static HostServices hostServices;

    @Override
    public void start(Stage stage) {
        primaryStage = stage;
        hostServices = getHostServices();
        stage.setTitle("Evento Manager");

        try {
            Database.initialize();
        } catch (RuntimeException e) {
            Dialogs.error(null, "Aplikacija se ne može povezati s bazom podataka.\n\n"
                    + "Provjerite da je MySQL pokrenut i da su podaci u db.properties ispravni.\n"
                    + "Adresa: " + AppConfig.dbUrl() + "\nKorisnik: " + AppConfig.dbUser()
                    + (e.getCause() != null ? "\n\nDetalji: " + e.getCause().getMessage() : ""));
            Platform.exit();
            return;
        }
        showLogin();
        stage.show();
    }

    public static Stage stage() {
        return primaryStage;
    }

    public static void showLogin() {
        Session.end();
        ViewLoader.Loaded<LoginController> login = ViewLoader.load("LoginView");
        setRoot(login.root(), 1000, 640, false);
    }

    public static void showMain() {
        ViewLoader.Loaded<?> main = ViewLoader.load("MainView");
        setRoot(main.root(), 1320, 820, true);
    }

    private static void setRoot(Parent root, double width, double height, boolean resizable) {
        Theme.apply(root);
        Scene scene = new Scene(root, width, height);
        primaryStage.setScene(scene);
        primaryStage.setResizable(resizable);
        primaryStage.setMinWidth(resizable ? 1100 : width);
        primaryStage.setMinHeight(resizable ? 700 : height);
        primaryStage.sizeToScene();
        primaryStage.centerOnScreen();
    }

    public static void openFile(Path file) {
        hostServices.showDocument(file.toUri().toString());
    }

    public static void main(String[] args) {
        launch(args);
    }
}
