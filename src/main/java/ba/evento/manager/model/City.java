package ba.evento.manager.model;

public record City(long id, String name) {

    @Override
    public String toString() {
        return name;
    }
}
