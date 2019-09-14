package lithium.io.server.storage;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import lithium.io.server.model.Bundle;

public class DBOBundle {
    static void createTable() throws SQLException {
        String sql = "CREATE TABLE 'bundle' ('rowid'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"+
        "'bundleid'	INTEGER NOT NULL,'name'	TEXT NOT NULL);";
        DBO.getDB().executeUpdate(sql);
    }

    public static void add(Bundle bundle) throws SQLException {
        String sql = "INSERT INTO 'bundle' ('bundleid','name') " + "values ("  +
        Integer.toString(bundle.getBundleId()) + ",'" + bundle.getName() + "');";
        DBO.getDB().executeUpdate(sql);
    }

    public static Bundle get(int id) throws SQLException {
        String sql = "SELECT rowid,bundleid,name from 'bundle' WHERE ROWID=" + Integer.toString(id) + ";";
        ResultSet rs = DBO.getDB().executeQuery(sql);
        Bundle bundle = new Bundle();
        while (rs.next()) { // read the result set
            bundle.setId(rs.getInt("rowid"));
            bundle.setBundleId(rs.getInt("bundleid"));
            bundle.setName(rs.getString("name"));            
            return bundle;
        }
        return null;
    }

    public static List<Bundle> getList() throws SQLException {
        List<Bundle> bundles = new ArrayList<Bundle>();
        String sql = "SELECT rowid,bundleid,name from 'bundle';";
        ResultSet rs = DBO.getDB().executeQuery(sql);
        while (rs.next()) { // read the result set
            Bundle bundle = new Bundle();
            bundle.setId(rs.getInt("rowid"));
            bundle.setBundleId(rs.getInt("bundleid"));
            bundle.setName(rs.getString("name"));            
            bundle.setMe("");
            bundles.add(bundle);
        }
        return bundles;
    }

	public static void delete(int id) throws SQLException {
        String sql = "DELETE FROM 'bundle' WHERE 'rowid' =" + Integer.toString(id) + "'";
        DBO.getDB().executeUpdate(sql);
	}

	public static void update(Bundle bundle) throws SQLException {
        String sql = "UPDATE 'bundle' SET 'name'='" + bundle.getName() + "' WHERE 'rowid' =" + bundle.getId() + ";";        
        DBO.getDB().executeUpdate(sql);
	}
}