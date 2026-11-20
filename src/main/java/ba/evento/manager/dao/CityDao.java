package ba.evento.manager.dao;

import ba.evento.manager.model.City;
import ba.evento.manager.util.Jdbc;

import java.util.List;
import java.util.Optional;

public class CityDao {

    public List<City> findAll() {
        return Jdbc.query("SELECT id, name FROM cities ORDER BY name",
                rs -> new City(rs.getLong("id"), rs.getString("name")));
    }

    public Optional<City> findById(long id) {
        return Jdbc.queryOne("SELECT id, name FROM cities WHERE id = ?",
                rs -> new City(rs.getLong("id"), rs.getString("name")), id);
    }

    public long insert(String name) {
        return Jdbc.insert("INSERT INTO cities (name) VALUES (?)", name);
    }

    public void update(long id, String name) {
        Jdbc.update("UPDATE cities SET name = ? WHERE id = ?", name, id);
    }

    public void delete(long id) {
        Jdbc.update("DELETE FROM cities WHERE id = ?", id);
    }
}
