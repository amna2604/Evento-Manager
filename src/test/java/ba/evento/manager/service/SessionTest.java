package ba.evento.manager.service;

import ba.evento.manager.model.Promotion;
import ba.evento.manager.model.PromotionStatus;
import ba.evento.manager.model.ReportStatus;
import ba.evento.manager.model.Role;
import ba.evento.manager.model.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

class SessionTest {

    private static User user(Role role, Long cityId) {
        return new User(1, "test", "hash", "Test Korisnik", role, cityId,
                cityId == null ? null : "Sarajevo", true);
    }

    private static Promotion promotion(long cityId) {
        return Promotion.create("Test promocija", 1L, cityId, "Centar",
                LocalDate.now(), null, null, 2, BigDecimal.TEN);
    }

    private static Promotion lockedPromotion(long cityId) {
        return new Promotion(1, "Zavrsena promocija", 1L, null, cityId, null, "Centar",
                LocalDate.now(), PromotionStatus.ZAVRSENA, null, null, null,
                ReportStatus.ODOBREN, 2, BigDecimal.TEN, 2);
    }

    @AfterEach
    void tearDown() {
        Session.end();
    }

    @Test
    void managerSeesAllCities() {
        Session.start(user(Role.MENADZER, null));
        assertNull(Session.cityScope());
    }

    @Test
    void coordinatorSeesOnlyOwnCity() {
        Session.start(user(Role.KOORDINATOR, 2L));
        assertEquals(2L, Session.cityScope());
    }

    @Test
    void managerCanEditAnyCity() {
        Session.start(user(Role.MENADZER, null));
        assertTrue(Session.canEdit(promotion(5L)));
    }

    @Test
    void coordinatorCanEditOnlyOwnCity() {
        Session.start(user(Role.KOORDINATOR, 2L));
        assertTrue(Session.canEdit(promotion(2L)));
        assertFalse(Session.canEdit(promotion(3L)));
    }

    @Test
    void lockedPromotionCannotBeEdited() {
        Session.start(user(Role.MENADZER, null));
        assertFalse(Session.canEdit(lockedPromotion(5L)));
    }

    @Test
    void sessionWithoutUserThrows() {
        Session.end();
        assertThrows(IllegalStateException.class, Session::user);
    }
}