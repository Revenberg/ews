package lithium.io.server.model;

import lithium.io.server.storage.DBOSong;

import javax.validation.constraints.NotNull;

import java.sql.SQLException;
import java.util.List;

public class Song {
    @NotNull
    private int id;
    @NotNull
    private int bundleId;
    @NotNull
    private int songId;
    @NotNull
    private String me;
    @NotNull
    private String name;

    public Song() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSongId() {
        return songId;
    }

    public void setSongId(int songId) {
        this.songId = songId;
    }

    public int getBundleId() {
        return bundleId;
    }

    public void setBundleId(int bundleId) {
        this.bundleId = bundleId;
    }
    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }
    public String getMe() {
        return me;
    }

    public static Song get(int id) throws SQLException {
        return DBOSong.get(id);
    }
       public void add() throws SQLException {
        DBOSong.add(this);
    }

    public static List<Song> getList() throws SQLException {
        return DBOSong.getList();
    }
    
    public static List<Song> getAllSongOfBundle(int bundleId) throws SQLException {
        return DBOSong.getListOfBundle(bundleId);
    }

    public static List<Song> getAllSongByName(String name) throws SQLException {
        return DBOSong.getListByName(name);
    }
    public void setMe(String s) {
        this.me = "/rest/role/" + Integer.toString(this.id);
    }
    
	public void delete() throws SQLException {
        DBOSong.delete(this.getId());
	}

	public void update() throws SQLException {
        DBOSong.update(this);
	}
}