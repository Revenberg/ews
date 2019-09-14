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


public class Resource_Text {
    private static Logger log = Logger.getLogger(Resource_Text.class.getName());
    private static int rowid = 0;
    //private int foreground_resource_id1=-1;
    //private int foreground_resource_id2=-1;
    //private int foreground_resource_id3=-1;

    private static int nextRowId() {
        if (rowid == 0) {
            rowid = Schedule.db.getMaxRowId("resource_text");
        }
        rowid = rowid + 1;
        return rowid;
    }

    public static int addResourceTextSql(String rtf) throws SQLException {
        String sql;
        int resource_id = Resource.addResource(6);
        sql = "INSERT INTO 'resource_text' ('rowid','resource_id','rtf') VALUES (" + Integer.toString(nextRowId()) + ","
                + Integer.toString(resource_id) + ",'" + rtf + "');";
        Schedule.db.executeUpdate(sql);
        return resource_id;
    }
}