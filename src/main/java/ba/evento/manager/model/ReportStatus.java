package ba.evento.manager.model;

public enum ReportStatus {
    NACRT("Nacrt"),
    PREDAN("Predan"),
    ODOBREN("Odobren"),
    VRACEN("Vraćen na doradu");

    private final String label;

    ReportStatus(String label) {
        this.label = label;
    }

    public String label() {
        return label;
    }

    /** Koordinator moze mijenjati izvjestaj dok nije predan ili odobren. */
    public boolean isEditable() {
        return this == NACRT || this == VRACEN;
    }

    public boolean canSubmit() {
        return isEditable();
    }

    public boolean canBeReviewed() {
        return this == PREDAN;
    }

    @Override
    public String toString() {
        return label;
    }
}
