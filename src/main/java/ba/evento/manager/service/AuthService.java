package ba.evento.manager.service;

import ba.evento.manager.dao.UserDao;
import ba.evento.manager.model.User;
import ba.evento.manager.util.PasswordHasher;
import ba.evento.manager.util.Validators;

public class AuthService {

    private final UserDao userDao = new UserDao();


    public User login(String username, String password) {
        if (Validators.isBlank(username) || Validators.isBlank(password)) {
            throw new IllegalArgumentException("Unesite korisničko ime i lozinku.");
        }
        User user = userDao.findByUsername(username.trim().toLowerCase())
                .filter(u -> PasswordHasher.matches(password, u.passwordHash()))
                .orElseThrow(() -> new IllegalArgumentException("Pogrešno korisničko ime ili lozinka."));
        if (!user.active()) {
            throw new IllegalArgumentException("Račun je deaktiviran. Obratite se menadžeru.");
        }
        return user;
    }

    public void changePassword(User user, String oldPassword, String newPassword) {
        if (!PasswordHasher.matches(oldPassword, user.passwordHash())) {
            throw new IllegalArgumentException("Trenutna lozinka nije ispravna.");
        }
        String error = Validators.passwordError(newPassword);
        if (error != null) {
            throw new IllegalArgumentException(error);
        }
        userDao.updatePassword(user.id(), PasswordHasher.hash(newPassword));
    }
}