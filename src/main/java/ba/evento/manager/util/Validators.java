package ba.evento.manager.util;

import java.math.BigDecimal;
import java.util.Optional;
import java.util.OptionalInt;
import java.util.regex.Pattern;

/** Provjere unosa iz formi. Metode koje vracaju String vracaju poruku o gresci ili null. */
public final class Validators {

    private static final Pattern USERNAME = Pattern.compile("[a-z0-9._]{3,30}");
    private static final Pattern PHONE = Pattern.compile("[0-9+ /\\-]{6,20}");

    private Validators() {
    }

    public static boolean isBlank(String value) {
        return value == null || value.isBlank();
    }

    public static boolean isValidUsername(String username) {
        return username != null && USERNAME.matcher(username).matches();
    }

    public static boolean isValidPhone(String phone) {
        return isBlank(phone) || PHONE.matcher(phone.trim()).matches();
    }

    public static String passwordError(String password) {
        if (password == null || password.length() < 6) {
            return "Lozinka mora imati najmanje 6 znakova.";
        }
        return null;
    }

    /** Cijeli broj >= 0; prazan ili neispravan unos daje prazan rezultat. */
    public static OptionalInt parseQuantity(String text) {
        if (isBlank(text)) {
            return OptionalInt.empty();
        }
        try {
            int value = Integer.parseInt(text.trim());
            return value >= 0 ? OptionalInt.of(value) : OptionalInt.empty();
        } catch (NumberFormatException e) {
            return OptionalInt.empty();
        }
    }

    /** Iznos u KM; prihvata i zarez kao decimalni separator. */
    public static Optional<BigDecimal> parseAmount(String text) {
        if (isBlank(text)) {
            return Optional.empty();
        }
        try {
            BigDecimal value = new BigDecimal(text.trim().replace(',', '.'));
            return value.signum() >= 0 ? Optional.of(value) : Optional.empty();
        } catch (NumberFormatException e) {
            return Optional.empty();
        }
    }
}
