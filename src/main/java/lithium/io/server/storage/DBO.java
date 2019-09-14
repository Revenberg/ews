package lithium.io.server.storage;

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
    public static SqliteDatabase getDB() throws SQLException {
        if (db == null) {
            openDatabase();
        }
        return db;
    }
    
}