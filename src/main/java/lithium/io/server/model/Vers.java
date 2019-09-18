package lithium.io.server.model;

import javax.validation.constraints.NotNull;

import lithium.io.server.storage.DBOVers;

import java.sql.SQLException;
import java.util.List;

public class Vers {

    @NotNull
    private int id;
    @NotNull
    private int songId;
    @NotNull
    private int vers;
    @NotNull
    private String name;
    @NotNull
    private String location;
    @NotNull
    private String me;
    
    public Vers() {
    }

    public int getId() {
        return id;
    }

    public int getSongId() {
        return this.songId;
    }

    public void setSongId(int songId) {
        this.songId = songId;
    }

    public String getMe() {
        return me;
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }
    
    public String getLocation() {
        return location;
    }

    public void setLocation(final String location) {
        this.location = location;
    }

    public Vers add() throws SQLException {
        return DBOVers.add(this);
    }

    public static List<Vers> getListBySongId(int songId) throws SQLException {
        return DBOVers.getList(songId);
    }

    public void setMe(String s) {
        this.me = "/rest/vers/" + Integer.toString(this.id);
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getVers() {
        return this.vers;
    }
    
	public void setVers(int vers) {
        this.vers = vers;
	}
    public void delete() throws SQLException {
        DBOVers.delete(this.getId());
	}

	public void update() throws SQLException {
        DBOVers.update(this);
	}

	public static Vers get(int id) throws SQLException {
        return DBOVers.get(id);
    }
}