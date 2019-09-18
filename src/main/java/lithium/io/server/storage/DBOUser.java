package lithium.io.server.storage;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import lithium.io.server.model.User;

public class DBOUser {

    static void createTable() throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS 'user' (" + "'rowid' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
                + "'name' text,'email' text);";
        DBO.getDB().executeUpdate(sql);
    }

    public static void add(User user) throws SQLException {
        String sql = "INSERT INTO 'user' ('name','email') " + "values ('" + user.getName() + "','" + user.getEmail()
                + "');";
        DBO.getDB().executeUpdate(sql);
    }

    public static User get(int id) throws SQLException {
        String sql = "SELECT rowid,name,email from 'user' WHERE ROWID=" + Integer.toString(id) + ";";
        ResultSet rs = DBO.getDB().executeQuery(sql);
        User user = new User();
        while (rs.next()) { // read the result set
            user.setId(rs.getInt("rowid"));
            user.setName(rs.getString("name"));
            user.setEmail(rs.getString("email"));
            return user;
        }
        return null;
    }

    public static void update(User user) throws SQLException {
        String sql = "UPDATE 'user' SET 'name'='" + user.getName() + "',email'='" + user.getEmail()
                + "' WHERE 'rowid' =" + user.getId() + "'";
        DBO.getDB().executeUpdate(sql);
    }

    public static void delete(int id) throws SQLException {
        String sql = "DELETE FROM 'user' WHERE 'rowid' =" + Integer.toString(id) + "'";
        DBO.getDB().executeUpdate(sql);
    }

    public static List<User> getList() throws SQLException {
        List<User> users = new ArrayList<User>();
        String sql = "SELECT rowid,name,email from 'user';";
        ResultSet rs = DBO.getDB().executeQuery(sql);
        while (rs.next()) { // read the result set
            User user = new User();
            user.setId(rs.getInt("rowid"));
            user.setName(rs.getString("name"));
            user.setEmail(rs.getString("email"));
            users.add(user);
        }
        return users;
    }
}