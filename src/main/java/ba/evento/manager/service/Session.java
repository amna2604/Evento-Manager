package ba.evento.manager.service;

import ba.evento.manager.model.User;

public final class Session {

    private static User current;

    private Session() {
    }

    public static void start(User user) {
        current = user;
    }

    public static void end() {
        current = null;
    }

    public static User user() {
        if (current == null) {
            throw new IllegalStateException("Nema prijavljenog korisnika");
        }
        return current;
    }

    public static boolean isManager() {
        return user().isManager();
    }

    public static Long cityScope() {
        return isManager() ? null : user().cityId();
    }

    public static boolean canEdit(ba.evento.manager.model.Promotion promotion) {
        if (promotion.isLocked()) {
            return false;
        }
        return isManager() || (user().cityId() != null && user().cityId() == promotion.cityId());
    }
}

