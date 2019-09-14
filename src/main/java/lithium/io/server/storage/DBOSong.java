package lithium.io.server.storage;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import lithium.io.server.model.Song;

public class DBOSong {
    static void createTable() throws SQLException {
        String sql = "CREATE TABLE 'song' ('rowid' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"+
        "'bundleid'	INTEGER NOT NULL,'songid'	INTEGER NOT NULL,  'name'	TEXT NOT NULL);";
        DBO.getDB().executeUpdate(sql);
    }

    public static void add(Song song) throws SQLException {
        String sql = "INSERT INTO 'song' ('bundleid','songid','name') " + "values (" +
        Integer.toString(song.getSongId()) + "," + Integer.toString(song.getBundleId()) + ",'" + 
        song.getName() + "');";
        DBO.getDB().executeUpdate(sql);
    }

    public static Song get(int id) throws SQLException {
        String sql = "SELECT rowid,bundleid,songid,name from 'song' WHERE ROWID=" + Integer.toString(id) + ";";
        ResultSet rs = DBO.getDB().executeQuery(sql);
        Song song = new Song();
        while (rs.next()) { // read the result set
            song.setId(rs.getInt("rowid"));
            song.setBundleId(rs.getInt("bundleid"));
            song.setSongId(rs.getInt("songid"));
            song.setName(rs.getString("name"));            
            return song;
        }
        return null;
    }

    private static List<Song> getListbySql(String sql) throws SQLException {
        List<Song> songs = new ArrayList<Song>();
        ResultSet rs = DBO.getDB().executeQuery(sql);
        while (rs.next()) { // read the result set
            Song song = new Song();
            song.setId(rs.getInt("rowid"));
            song.setBundleId(rs.getInt("bundleid"));
            song.setSongId(rs.getInt("songid"));
            song.setName(rs.getString("name"));            
            song.setMe("");
            songs.add(song);
        }
        return songs;
    }
    public static List<Song> getList() throws SQLException {
        String sql = "SELECT rowid,bundleid,songid,name from 'song';";
        return getListbySql(sql);
    }

	public static List<Song> getListOfBundle(int bundleId) throws SQLException {
		String sql = "SELECT rowid,bundleid,songid,name from 'song' where bundleid=" + Integer.toString(bundleId) + ";";
        return getListbySql(sql);
	}

	public static List<Song> getListByName(String name) throws SQLException {
		String sql = "SELECT rowid,bundleid,songid,name from 'song' where name='" + name+ "';";
        return getListbySql(sql);
	}


	public static void delete(int id) throws SQLException {
        String sql = "DELETE FROM 'song' WHERE 'rowid' =" + Integer.toString(id) + "'";
        DBO.getDB().executeUpdate(sql);
	}

	public static void update(Song song) throws SQLException {
        String sql = "UPDATE 'song' SET 'name'='" + song.getName() + "' WHERE 'rowid' =" + song.getId() + ";";        
        DBO.getDB().executeUpdate(sql);
	}

}