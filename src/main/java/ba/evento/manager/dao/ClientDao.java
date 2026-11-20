package ba.evento.manager.dao;

import ba.evento.manager.model.Client;
import ba.evento.manager.util.Jdbc;

import java.util.List;

public class ClientDao {

    public List<Client> findAll() {
        return Jdbc.query("SELECT id, name, contact FROM clients ORDER BY name",
                rs -> new Client(rs.getLong("id"), rs.getString("name"), rs.getString("contact")));
    }

    public long insert(String name, String contact) {
        return Jdbc.insert("INSERT INTO clients (name, contact) VALUES (?, ?)", name, contact);
    }

    public void update(long id, String name, String contact) {
        Jdbc.update("UPDATE clients SET name = ?, contact = ? WHERE id = ?", name, contact, id);
    }

    public void delete(long id) {
        Jdbc.update("DELETE FROM clients WHERE id = ?", id);
    }
}
