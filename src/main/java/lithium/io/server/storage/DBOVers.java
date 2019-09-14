package lithium.io.server.storage;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import lithium.io.server.model.Vers;

public class DBOVers {
    static void createTable() throws SQLException {
        String sql = "CREATE TABLE 'vers' ('rowid'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
                + "'songid'	INTEGER NOT NULL,'vers'	INTEGER NOT NULL,'name'	INTEGER NOT NULL);";
        DBO.getDB().executeUpdate(sql);
    }

    public static void add(Vers vers) throws SQLException {
        String sql = "INSERT INTO 'vers' ('songid','vers','name') " + "values (" + Integer.toString(vers.getId()) + ","
                + Integer.toString(vers.getSongId()) + ",'" + Integer.toString(vers.getVers()) + "," + vers.getName()
                + "');";
        DBO.getDB().executeUpdate(sql);
    }

    public static Vers get(int id) throws SQLException {
        String sql = "SELECT rowid,name,activate from 'vers' WHERE ROWID=" + Integer.toString(id) + ";";
        ResultSet rs = DBO.getDB().executeQuery(sql);
        Vers vers = new Vers();
        while (rs.next()) { // read the result set
            vers.setId(rs.getInt("rowid"));
            vers.setSongId(rs.getInt("songid"));
            vers.setName(rs.getString("name"));
            return vers;
        }
        return null;
    }

    public static List<Vers> getList(int songId) throws SQLException {
        List<Vers> verses = new ArrayList<Vers>();
        String sql = "SELECT rowid,songid,vers,name from 'vers' where songid=" + songId + ";";
        ResultSet rs = DBO.getDB().executeQuery(sql);
        while (rs.next()) { // read the result set
            Vers vers = new Vers();
            vers.setId(rs.getInt("rowid"));
            vers.setSongId(rs.getInt("Songid"));
            vers.setVers(rs.getInt("vers"));
            vers.setName(rs.getString("name"));

            vers.setMe("");
            verses.add(vers);
        }
        return verses;
    }

    public static void delete(int id) throws SQLException {
        String sql = "DELETE FROM 'vers' WHERE 'rowid' =" + Integer.toString(id) + "'";
        DBO.getDB().executeUpdate(sql);
	}

	public static void update(Vers vers) throws SQLException {
        String sql = "UPDATE 'song' SET 'name'='" + vers.getName() + "' WHERE 'rowid' =" + vers.getId() + ";";        
        DBO.getDB().executeUpdate(sql);
	}


}