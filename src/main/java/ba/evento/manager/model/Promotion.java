package ba.evento.manager.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public record Promotion(
        long id,
        String title,
        long clientId,
        String clientName,
        long cityId,
        String cityName,
        String location,
        LocalDate date,
        PromotionStatus status,
        Long coordinatorId,
        String coordinatorName,
        String notes,
        ReportStatus reportStatus,
        int requiredPromoters,
        BigDecimal allowance,
        int assignedPromoters) {

    /** Nova promocija koja jos nije spremljena u bazu. */
    public static Promotion create(String title, long clientId, long cityId, String location,
                                   LocalDate date, Long coordinatorId, String notes,
                                   int requiredPromoters, BigDecimal allowance) {
        return new Promotion(0, title, clientId, null, cityId, null, location, date,
                PromotionStatus.PLANIRANA, coordinatorId, null, notes, null, requiredPromoters, allowance, 0);
    }

    /** Nakon odobrenja izvjestaja (promocija je zavrsena) ili otkazivanja podaci se vise ne mijenjaju. */
    public boolean isLocked() {
        return status == PromotionStatus.ZAVRSENA || status == PromotionStatus.OTKAZANA
                || reportStatus == ReportStatus.ODOBREN;
    }

    public boolean needsMorePromoters() {
        return assignedPromoters < requiredPromoters;
    }

    @Override
    public String toString() {
        return title;
    }
}
