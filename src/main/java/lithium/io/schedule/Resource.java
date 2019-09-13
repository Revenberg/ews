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

import java.sql.SQLException;
import java.util.logging.Logger;

public class Resource {
    private static Logger log = Logger.getLogger(Resource.class.getName());
    private static int rowid;

    private static int nextRowId() {
        if (rowid == 0) {
            rowid = SqliteDatabase.getMaxRowId("resource");
        }
        rowid = rowid + 1;
        return rowid;
    }

    public static int addResource(int resource_type) throws SQLException {
        String sql;
        sql = "INSERT INTO 'resource' ('rowid','resource_hash','resource_uid','resource_type','title','author','copyright','description','tags') "
                + "VALUES (" + Integer.toString(nextRowId()) + ",NULL,'" + Tools.uuid() + "',"
                + Integer.toString(resource_type) + ",'','','','','');";
        SqliteDatabase.executeUpdate(sql);
        return rowid;
    }

    public static int addResource(int resource_type, String fileName) throws SQLException {
        String sql;
        sql = "INSERT INTO 'resource' ('rowid','resource_hash','resource_uid','resource_type','title','author','copyright','description','tags') "
                + "VALUES (" + Integer.toString(nextRowId()) + ",NULL,'" + Tools.uuid() + "',"
                + Integer.toString(resource_type) + ",'" + fileName + "','','','','');";
        SqliteDatabase.executeUpdate(sql);
        return rowid;
    }

    public Resource() {
    }
}