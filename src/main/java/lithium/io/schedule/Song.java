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

public class Song {
    private static Logger log = Logger.getLogger(Song.class.getName());
    private int rowid;


    private void element_property_group() throws SQLException {
        log.info("element_property_group");
        String sql;
    
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (1,3,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (2,3,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (3,4,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (4,4,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (5,5,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (6,5,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (7,5,'Element');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (8,8,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (9,8,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (10,9,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (11,9,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (12,13,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (13,13,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (14,14,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (15,14,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (16,18,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (17,18,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (18,21,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (19,21,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (20,22,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (21,22,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (22,25,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (23,25,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (24,28,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (25,28,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (26,29,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (27,29,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (28,30,'Text_Format');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') VALUES (29,30,'Overrides');";
        SqliteDatabase.executeUpdate(sql);
    }

    private void element_property() throws SQLException {
        log.info("element_property");
        String sql;
//        SqliteDatabase.executeUpdate("DELETE from 'element_property'");
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (1,2,5,'mofText','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (2,2,5,'mofDims','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (3,4,5,'mofText','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (4,5,5,'mofText','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (5,5,5,'mofDims','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (6,7,5,'Hidden','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (7,9,5,'mofText','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (8,11,5,'mofText','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (9,13,5,'mofText','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (10,15,5,'mofText','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (11,17,5,'mofDims','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (12,19,5,'mofDims','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (13,21,5,'mofDims','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (14,23,5,'mofDims','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (15,25,5,'mofDims','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (16,27,5,'mofDims','1');";
        SqliteDatabase.executeUpdate(sql);
        sql = "INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') VALUES (17,29,5,'mofDims','1');";
        SqliteDatabase.executeUpdate(sql);

    }

//    public void addPage(int slide_id, String rtf) throws SQLException {
//        Element element = new Element();
//        element.addElement(slide_id, rtf);
//    }

    public Song() throws SQLException {
        log.info("Test");

 //       try {
            log.info("Test");

            //element_property_group();
            element_property();

            // sql = "INSERT INTO 'info' ('rowid','version','version_min') VALUES
            // (1,'6.7.10.0','6.5.1.0');";
            // SqliteDatabase.executeUpdate(sql);
    //    } catch (SQLException e) {
            // TODO Auto-generated catch block
    //        e.printStackTrace();
   //     }
    }
}