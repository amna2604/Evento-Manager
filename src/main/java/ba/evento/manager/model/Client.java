package ba.evento.manager.model;

public record Client(long id, String name, String contact) {

    @Override
    public String toString() {
        return name;
    }
}
