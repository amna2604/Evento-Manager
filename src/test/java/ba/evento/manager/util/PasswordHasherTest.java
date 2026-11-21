package ba.evento.manager.util;

import ba.evento.manager.util.PasswordHasher;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

class PasswordHasherTest {

    @Test
    void correctPasswordMatches() {
        String hash = PasswordHasher.hash("tajna123");
        assertTrue(PasswordHasher.matches("tajna123", hash));
    }

    @Test
    void wrongPasswordDoesNotMatch() {
        String hash = PasswordHasher.hash("tajna123");
        assertFalse(PasswordHasher.matches("tajna124", hash));
    }

    @Test
    void samePasswordGivesDifferentHashesBecauseOfSalt() {
        assertNotEquals(PasswordHasher.hash("isto"), PasswordHasher.hash("isto"));
    }

    @Test
    void hashDoesNotContainPlainPassword() {
        assertFalse(PasswordHasher.hash("tajna123").contains("tajna123"));
    }

    @Test
    void malformedStoredValueIsRejected() {
        assertFalse(PasswordHasher.matches("x", "nije-hash"));
        assertFalse(PasswordHasher.matches("x", "pbkdf2$abc$!!$!!"));
        assertFalse(PasswordHasher.matches(null, PasswordHasher.hash("x")));
    }
}

