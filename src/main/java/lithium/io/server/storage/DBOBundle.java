package lithium.io.server.storage;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import lithium.io.server.model.Bundle;

public class DBOBundle {
    private static Logger log = Logger.getLogger(DBOBundle.class.getName());

    static void createTable() throws SQLException {
        String sql = "CREATE TABLE 'bundle' ('rowid'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
                + "'bundleid'	INTEGER NOT NULL,'name'	TEXT NOT NULL,'mnemonic'	TEXT);";
        DBO.getDB().executeUpdate(sql);
    }

    private static int getMaxBundleId() {
        int max = 0;
        try {
            ResultSet rs = DBO.getDB().executeQuery("select max(bundleid) as max from bundle");
            while (rs.next()) {
                max = rs.getInt("max");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return max;
    }

    public static Bundle add(Bundle bundle) throws SQLException {
        if (bundle.getBundleId() <= 0) {
            bundle.setBundleId(getMaxBundleId() + 1);
        }
        String sql = "INSERT INTO 'bundle' ('bundleid','name','mnemonic') " + "values (" + Integer.toString(bundle.getBundleId())
                + ",'" + bundle.getName().replace("'", "''") + "','" + bundle.getMnemonic().replace("'", "''") + "');";
        log.info(sql);
        DBO.getDB().executeUpdate(sql);
        if (bundle.getId() <= 0) {
            bundle.setId(DBO.getDB().getMaxRowId("bundle"));
        }
        return bundle;
    }

    public static Bundle get(int id) throws SQLException {
        String sql = "SELECT rowid,bundleid,name,mnemonic from 'bundle' WHERE ROWID=" + Integer.toString(id) + ";";
        ResultSet rs = DBO.getDB().executeQuery(sql);
        Bundle bundle = new Bundle();
        while (rs.next()) { // read the result set
            bundle.setId(rs.getInt("rowid"));
            bundle.setBundleId(rs.getInt("bundleid"));
            bundle.setName(rs.getString("name").replace("''", "'"));
            bundle.setMnemonic(rs.getString("mnemonic"));
            return bundle;
        }
        return null;
    }

    private static List<Bundle> getListSQL(String sql) throws SQLException {
        List<Bundle> bundles = new ArrayList<Bundle>();
        ResultSet rs = DBO.getDB().executeQuery(sql);
        while (rs.next()) { // read the result set
            Bundle bundle = new Bundle();
            bundle.setId(rs.getInt("rowid"));
            bundle.setBundleId(rs.getInt("bundleid"));
            bundle.setName(rs.getString("name").replace("''", "'"));
            bundle.setMnemonic(rs.getString("mnemonic"));
            bundle.setMe("");
            bundles.add(bundle);
        }
        return bundles;
    }

    public static List<Bundle> getList() throws SQLException {
        String sql = "SELECT rowid,bundleid,name,mnemonic from 'bundle';";
        return getListSQL(sql);
    }

    public static List<Bundle> getListByName(String name) throws SQLException {
        String sql = "SELECT rowid,bundleid,name,mnemonic from 'bundle' where name='" + name.replace("'", "''") + "';";
        log.info(sql);
        return getListSQL(sql);
    }

    public static List<Bundle> getListByMnemonic(String mnemonic) throws SQLException {
        String sql = "SELECT rowid,bundleid,name,mnemonic from 'bundle' where mnemonic='" + mnemonic.replace("'", "''") + "';";
        log.info(sql);
        return getListSQL(sql);
    }

    public static void delete(int id) throws SQLException {
        String sql = "DELETE FROM 'bundle' WHERE 'rowid' =" + Integer.toString(id) + "'";
        DBO.getDB().executeUpdate(sql);
    }

    public static void update(Bundle bundle) throws SQLException {
        String sql = "UPDATE 'bundle' SET 'name'='" + bundle.getName().replace("'", "''") + "', 'mnemonic'='"
                + bundle.getMnemonic().replace("'", "''") + "' WHERE 'rowid' =" + bundle.getId() + ";";
        DBO.getDB().executeUpdate(sql);
    }
}