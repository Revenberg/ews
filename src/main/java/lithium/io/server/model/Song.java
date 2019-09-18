package lithium.io.server.model;

import lithium.io.server.storage.DBOSong;

import javax.validation.constraints.NotNull;

import java.sql.SQLException;
import java.util.ArrayList;
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

    private List<String> next;

    public Song() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
        setMe(null);
        setNext(null);
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
    public List<String> getNext() {
        return next;
    }

    public void setNext(List<String> list) {        
        this.next = new ArrayList<String>();
        this.next.add("/rest/song/" + Integer.toString(this.id) + "/verses");        
        this.next.add("/rest/song/" + Integer.toString(this.id) + "/vers/add");        
    }


    public static Song get(int id) throws SQLException {
        return DBOSong.get(id);
    }
       public Song add() throws SQLException {
        List<Song> list = getListByName(this.getBundleId(), this.getName());
        if (list.size() == 0) {
            return DBOSong.add(this);
        } else {
            return list.get(0);
        }

    }

	private List<Song> getListByName(int bundleId, String name) throws SQLException {
        return DBOSong.getListByBundleName(bundleId, name);
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
        this.me = "/rest/song/" + Integer.toString(this.id);
    }
    
	public void delete() throws SQLException {
        DBOSong.delete(this.getId());
	}

	public void update() throws SQLException {
        DBOSong.update(this);
	}
}