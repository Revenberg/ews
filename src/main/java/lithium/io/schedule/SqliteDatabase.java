/*
 * Copyright 2019-2020 Sander Revenberg
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package lithium.io.schedule;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Logger;

public class SqliteDatabase {
    private static Logger log = Logger.getLogger(SqliteDatabase.class.getName());
    private Connection connection = null;
    private String databaseName;
    public void open(String databaseName) {
        try {
            Class.forName("org.sqlite.JDBC");
            // create a database connection
            connection = DriverManager.getConnection("jdbc:sqlite:" + databaseName);
            this.databaseName = databaseName;
        } catch (SQLException | ClassNotFoundException e) {
            // if the error message is "out of memory",
            // it probably means no database file is found
            System.err.println(e.getMessage());
        }
    }
    public String getdatabaseName() {
        return databaseName;
    }

    public  void close() {
        try {
            if (connection != null)
                connection.close();
        } catch (SQLException e) {
            // connection close failed.
            System.err.println(e);
        }
    }

    public void executeUpdate(String sql) throws SQLException {
       log.info("executeUpdate");
        log.info(getdatabaseName());
        Statement statement = connection.createStatement();
        statement.setQueryTimeout(30); // set timeout to 30 sec.
        log.info(sql);
        statement.executeUpdate(sql);        
    }

    public ResultSet executeQuery(String sql) throws SQLException {
        log.info("executeQuery");
        Statement statement = connection.createStatement();
        statement.setQueryTimeout(30); // set timeout to 30 sec.
        log.info(sql);
        return statement.executeQuery(sql);
    }

    public int getMaxRowId(String table) {
        int max = 0;
        try {
            ResultSet rs = executeQuery("select max(rowid) as max from " + table);
                while (rs.next()) { // read the result set
                    max = rs.getInt("max");
                }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return max;
    }
    public boolean existsTable(String table) {
        try {
            log.info(this.getdatabaseName());
            ResultSet rs = executeQuery("select name from sqlite_master where name='" + table +"';");
                if (rs.next()) { // read the result set
                    return true;
                }
        } catch (SQLException e) {
            return false;
        }
        return false;
    }
}
