package ba.evento.manager.controller;

import ba.evento.manager.Main;
import ba.evento.manager.model.User;
import ba.evento.manager.service.AuthService;
import ba.evento.manager.service.Session;
import ba.evento.manager.util.DataAccessException;
import ba.evento.manager.util.Icons;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.layout.StackPane;


public class LoginController {
    @FXML
    private StackPane logoBox;
    @FXML
    private TextField usernameField;
    @FXML
    private PasswordField passwordField;
    @FXML
    private Label errorLabel;
    @FXML
    private Button loginButton;

    private final AuthService authService = new AuthService();

    @FXML
    private void initialize() {
        var logo = ba.evento.manager.util.Branding.logo(130);
        if (logo != null) {
            logoBox.setPrefSize(170, 170);
            logoBox.setMinSize(170, 170);
            logoBox.setMaxSize(170, 170);
            logoBox.getChildren().add(logo);
        } else {
            logoBox.getChildren().add(Icons.of("star", 36));
        }
        hideError();
        usernameField.textProperty().addListener((obs, old, now) -> hideError());
        passwordField.textProperty().addListener((obs, old, now) -> hideError());
    }

    @FXML
    private void onLogin() {
        try {
            User user = authService.login(usernameField.getText(), passwordField.getText());
            Session.start(user);
            Main.showMain();
        } catch (IllegalArgumentException e) {
            showError(e.getMessage());
            passwordField.clear();
            passwordField.requestFocus();
        } catch (DataAccessException e) {
            showError("Greška pri radu s bazom podataka. Provjerite vezu.");
        }
    }

    private void showError(String message) {
        errorLabel.setText(message);
        errorLabel.setVisible(true);
        errorLabel.setManaged(true);
    }

    private void hideError() {
        errorLabel.setVisible(false);
        errorLabel.setManaged(false);
    }
}


