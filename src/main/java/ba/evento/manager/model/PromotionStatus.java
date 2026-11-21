package ba.evento.manager.model;

import java.util.List;

public enum PromotionStatus {
    PLANIRANA("Planirana"),
    U_TOKU("U toku"),
    ZAVRSENA("Završena"),
    OTKAZANA("Otkazana");

    private final String label;

    PromotionStatus(String label) {
        this.label = label;
    }

    public String label() {
        return label;
    }

    /**
     * Statusi u koje se promocija moze prebaciti rucno. Status ZAVRSENA se ne postavlja rucno:
     * promocija postaje zavrsena kad menadzer odobri zavrsni izvjestaj koordinatora.
     */
    public List<PromotionStatus> allowedNext(Role role) {
        boolean manager = role == Role.MENADZER;
        return switch (this) {
            case PLANIRANA -> manager ? List.of(U_TOKU, OTKAZANA) : List.of(U_TOKU);
            case U_TOKU -> manager ? List.of(OTKAZANA) : List.of();
            case ZAVRSENA -> List.of();
            case OTKAZANA -> manager ? List.of(PLANIRANA) : List.of();
        };
    }

    public String actionLabel() {
        return switch (this) {
            case PLANIRANA -> "Vrati u plan";
            case U_TOKU -> "Započni promociju";
            case ZAVRSENA -> "Završi promociju";
            case OTKAZANA -> "Otkaži promociju";
        };
    }

    @Override
    public String toString() {
        return label;
    }
}

