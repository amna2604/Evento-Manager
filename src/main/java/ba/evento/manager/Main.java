package ba.evento.manager;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Stage;

public class Main extends Application {
    @Override
    public void start(Stage stage) {
        stage.setTitle("Evento Manager");
        stage.setScene(new Scene(new Label("Evento Manager"), 800, 500));
        stage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}