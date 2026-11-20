package ba.evento.manager.dao;

import ba.evento.manager.model.User;
import ba.evento.manager.util.Database;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.condition.EnabledIfEnvironmentVariable;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;


@EnabledIfEnvironmentVariable(named = "EVENTO_DB_URL", matches = ".+")
class DatabaseIntegrationTest {

    @BeforeAll
    static void setUp() {
        Database.initialize();
    }

    @Test
    void demoDataIsSeededOnlyOnce() {
        int users = new UserDao().count();
        Database.initialize();
        assertEquals(users, new UserDao().count());
        assertTrue(users >= 2);
    }

    @Test
    void twoManagersAreAvailableInDemoData() {
        assertTrue(new UserDao().findAll().stream().filter(User::isManager).count() >= 2);
    }

    @Test
    void citiesAndClientsAreSeeded() {
        assertFalse(new CityDao().findAll().isEmpty());
        assertFalse(new ClientDao().findAll().isEmpty());
    }

    @Test
    void userCanBeFoundByUsername() {
        assertTrue(new UserDao().findByUsername("menadzer").isPresent());
        assertTrue(new UserDao().findByUsername("nepostoji").isEmpty());
    }
}