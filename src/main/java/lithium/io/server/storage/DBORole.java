package lithium.io.server.storage;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import lithium.io.server.model.Role;

public class DBORole {
    private static Logger log = Logger.getLogger(DBORole.class.getName());

    static void createTable() throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS 'role' (" + "'rowid' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
                + "'userid' integer NOT NULL, 'name'	text," + "'active'	boolean," + "PRIMARY KEY('rowid')" + ");";
        log.info(sql);
        DBO.getDB().executeUpdate(sql);
    }

    public static void add(Role role) throws SQLException {
        role.setId(DBO.getDB().getMaxRowId("role") + 1);
        String sql = "INSERT INTO 'role' ('userid','name','active') " + "values ("+ Integer.toString(role.getUserid()) + ",'" + role.getName() + "','" + Boolean.toString(role.getActive()) + "');";
        log.info(sql);
        DBO.getDB().executeUpdate(sql);
    }

    public static Role get(int id) throws SQLException {
        String sql = "SELECT rowid,name,activate from 'role' WHERE ROWID=" + Integer.toString(id) + ";";
        log.info(sql);
        ResultSet rs = DBO.getDB().executeQuery(sql);
        Role role = new Role();
        while (rs.next()) { // read the result set
            role.setId(rs.getInt("rowid"));
            role.setName(rs.getString("name"));
            role.setActive(rs.getBoolean("activate"));
            return role;
        }
        return null;
    }

    public static void delete(int id) throws SQLException {
        String sql = "DELETE FROM 'role' WHERE 'rowid' =" + Integer.toString(id) + "'";
        log.info(sql);
        DBO.getDB().executeUpdate(sql);
    }

    public static List<Role> getList(int userid) throws SQLException {
        log.info("getRoles");
        List<Role> roles = new ArrayList<Role>();
        String sql = "SELECT rowid,userid,name,active from 'role' where userid=" + userid + ";";
        log.info(sql);
        ResultSet rs = DBO.getDB().executeQuery(sql);
        while (rs.next()) { // read the result set
            Role role = new Role();
            role.setId(rs.getInt("rowid"));
            role.setUserid(rs.getInt("userid"));
            role.setName(rs.getString("name"));
            role.setActive(rs.getBoolean("active"));
            role.setMe("");
            roles.add(role);
        }
        return roles;
    }

    public static void active(Role role) throws SQLException {
        String sql = "UPDATE 'role' SET 'active'=" + Boolean.toString(role.getActive()) + " WHERE 'rowid' =" + role.getId()
                + " AND 'userid' =" + role.getUserid() + ";";
        log.info(sql);
        DBO.getDB().executeUpdate(sql);
    }

}