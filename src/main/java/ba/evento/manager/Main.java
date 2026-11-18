package ba.evento.manager;

import ba.evento.manager.util.Database;
import javafx.application.Application;
import javafx.application.Platform;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Label;
import javafx.stage.Stage;

public class Main extends Application {
    @Override
    public void start(Stage stage) {
        try {
            Database.initialize();
        } catch (RuntimeException e) {
            new Alert(Alert.AlertType.ERROR,
                    "Nije moguće povezati se s bazom.\nProvjerite da je MySQL pokrenut i podatke u db.properties.\n\n"
                            + e.getMessage()).showAndWait();
            Platform.exit();
            return;
        }


        stage.setTitle("Evento Manager");
        stage.setScene(new Scene(new Label("Evento Manager"), 800, 500));
        stage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}