package ba.evento.manager.util;

import ba.evento.manager.util.Validators;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class ValidatorsTest {

    @Test
    void usernameRules() {
        Assertions.assertTrue(Validators.isValidUsername("emir.hadzic"));
        assertFalse(Validators.isValidUsername("ab"));
        assertFalse(Validators.isValidUsername("Emir Hadžić"));
    }

    @Test
    void phoneIsOptionalButMustLookLikeAPhone() {
        assertTrue(Validators.isValidPhone(""));
        assertTrue(Validators.isValidPhone("061 123 456"));
        assertFalse(Validators.isValidPhone("abc"));
    }

    @Test
    void passwordNeedsSixCharacters() {
        assertNotNull(Validators.passwordError("12345"));
        assertNull(Validators.passwordError("123456"));
    }

    @Test
    void quantityParsing() {
        assertEquals(12, Validators.parseQuantity(" 12 ").getAsInt());
        assertTrue(Validators.parseQuantity("-1").isEmpty());
        assertTrue(Validators.parseQuantity("1,5").isEmpty());
        assertTrue(Validators.parseQuantity("").isEmpty());
    }

    @Test
    void amountAcceptsCommaAsDecimalSeparator() {
        assertEquals(new BigDecimal("40.50"), Validators.parseAmount("40,50").orElseThrow());
        assertTrue(Validators.parseAmount("-5").isEmpty());
        assertTrue(Validators.parseAmount("abc").isEmpty());
    }
}
