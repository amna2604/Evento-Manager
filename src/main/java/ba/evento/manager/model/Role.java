package ba.evento.manager.model;

public enum Role {
    MENADZER("Menadžer"),
    KOORDINATOR("Koordinator");

    private final String label;

    Role(String label) {
        this.label = label;
    }

    public String label() {
        return label;
    }

    @Override
    public String toString() {
        return label;
    }
}
