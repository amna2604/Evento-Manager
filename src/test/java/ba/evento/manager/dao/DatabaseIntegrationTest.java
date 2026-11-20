package ba.evento.manager.dao;

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

// ovdje idu četiri testa: demoDataIsSeededOnlyOnce,
// twoManagersAreAvailableInDemoData, citiesAndClientsAreSeeded,
// userCanBeFoundByUsername