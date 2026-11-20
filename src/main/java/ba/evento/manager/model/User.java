package ba.evento.manager.model;

public record User(
        long id,
        String username,
        String passwordHash,
        String fullName,
        Role role,
        Long cityId,
        String cityName,
        boolean active) {

    public boolean isManager() {
        return role == Role.MENADZER;
    }

    @Override
    public String toString() {
        return fullName;
    }
}
