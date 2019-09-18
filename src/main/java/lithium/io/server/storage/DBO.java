package lithium.io.server.storage;

import java.sql.ResultSet;
import java.sql.SQLException;

import lithium.io.schedule.SqliteDatabase;
import lithium.io.schedule.Tools;

public class DBO {
    private static SqliteDatabase db;

    public static void openDatabase() throws SQLException {
        db = new SqliteDatabase();
        db.open(Tools.tempDir + "/user.db");
        if (!db.existsTable("user")) {
            DBOUser.createTable();
        }
        if (!db.existsTable("role")) {
            DBORole.createTable();
        }
        if (!db.existsTable("bundle")) {
            DBOBundle.createTable();
        }
        if (!db.existsTable("vers")) {
            DBOVers.createTable();
        }
        if (!db.existsTable("song")) {
            DBOSong.createTable();
        }
    }

    public int getMaxRowId(String table) throws SQLException {
        if (db == null) {
            openDatabase();
        }
        int max = 0;
        try {
            ResultSet rs = db.executeQuery("select max(rowid) as max from " + table);
                while (rs.next()) { // read the result set
                    max = rs.getInt("max");
                }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return max;
    }

    public static SqliteDatabase getDB() throws SQLException {
        if (db == null) {
            openDatabase();
        }
        return db;
    }
    
}