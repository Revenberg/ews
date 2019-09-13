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

public class Presentation {
    private static Logger log = Logger.getLogger(Presentation.class.getName());
    private static int order = 0;
    private int presentation_id = 0;

    public Presentation(int presentation_type, String text) throws SQLException {
        log.info("presentation");
        String sql;
        presentation_id = SqliteDatabase.getMaxRowId("presentation") + 1;

        if ((presentation_type == 11) || (presentation_type == 13)) {
            sql = "INSERT INTO 'presentation' ('rowid','presentation_uid','presentation_rev_uid','presentation_global_uid','presentation_type','aspect_ratio','group_level','order_index','thumbnail_slide_id','layout_revision','thumbnail_desired_rev','thumbnail_rev','thumbnail','auto_theme','looping','title','author','copyright','administrator','description','tags','reference_number','vendor_id','notes','modified_date','ready','error_no') VALUES ("
                    + Integer.toString(presentation_id) + ",'" + text.toUpperCase() + "','6.0.7',NULL,"
                    + Integer.toString(presentation_type) + ",''," + Integer.toString(order)
                    + ",0,NULL,NULL,NULL,NULL,NULL,1,0,'" + text
                    + "','','','','','','',NULL,'',132120916145610000,1,0);";
            SqliteDatabase.executeUpdate(sql);
            order++;
        }
        if ((presentation_type == 6) || (presentation_type == 8)) {
            sql = "INSERT INTO 'presentation' ('rowid','presentation_uid','presentation_rev_uid','presentation_global_uid','presentation_type','aspect_ratio','group_level','order_index','thumbnail_slide_id','layout_revision','thumbnail_desired_rev','thumbnail_rev','thumbnail','auto_theme','looping','title','author','copyright','administrator','description','tags','reference_number','vendor_id','notes','modified_date','ready','error_no') VALUES ("
                    + Integer.toString(presentation_id) + ",NULL,NULL,NULL," + Integer.toString(presentation_type)
                    + ",'',0,0,NULL,NULL,NULL,NULL,NULL,0,0,'" + text + "','','','','','','',NULL,'',NULL,1,0);";
            SqliteDatabase.executeUpdate(sql);
            order++;
        }

    }

    public int getpresentation_id() {
        return presentation_id;
    }
}