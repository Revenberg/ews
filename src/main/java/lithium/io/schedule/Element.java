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

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

public class Element {
    private static Logger log = Logger.getLogger(Element.class.getName());
    private static int rowid = 0;
    private int order = 0;

    private static int nextRowId() {
        if (rowid == 0) {
            rowid = Schedule.db.getMaxRowId("element");
        }
        rowid = rowid + 1;
        return rowid;
    }

    // public static int addResource(int resource_type) throws SQLException {
    // String sql;
    // sql = "";
    // Schedule.db.executeUpdate(sql);
    // return rowid;
    // }

    public void addPage(int slide_id) throws SQLException {
        String sql;
        int row_id;
        int epg;
        // BACKGROUND
        row_id = nextRowId();
        sql = "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') "
                + " VALUES (" + Integer.toString(row_id) + "," + Integer.toString(slide_id) + ",'BACKGROUND',0,0,"
                + NextOrder() + ",0.0,0.0,1.0,1.0,NULL,NULL,0,0);";
        Schedule.db.executeUpdate(sql);
   //     epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Text_Format");
        
   //     ElementProperty.addElementProperty(epg, 5, "mofText", "1");
   //     ElementProperty.addElementProperty(epg, 5, "mofDims", "1");

        // AUDIO
        row_id = nextRowId();
        sql = "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') "
                + " VALUES (" + Integer.toString(row_id) + "," + Integer.toString(slide_id) + ",'AUDIO',5,0,"
                + NextOrder() + ",0.0,0.0,1.0,1.0,NULL,NULL,0,0);";
        Schedule.db.executeUpdate(sql);
        //     ElementProperty.addElementProperty(epg, 5, "mofText", "1");
        // ElementProperty.addElementProperty(epg, 5, "mofDims", "1");
    }

    private int NextOrder() {
        order++;
        return order - 1;
    }

    public void addImagePage(int slide_id, String label, String fileName, String ext) throws SQLException, IOException {
        int row_id;
        int epg;
        String sql;

        String rtf = "{\\rtf1\\ansi\\deff0\\sdeasyworship2\n\n{\\fonttbl{\\f0 Tahoma;}}\n\n{\\colortbl ;}\n\n{\\pard\\sdlistlevel-1\\qc\\qdef\\sdewparatemplatestyle300{\\*\\sdasfactor 1}{\\*\\sdasbaseline 32.4}\\sdastextstyle300\\plain\\sdewtemplatestyle300\\fs64{\\*\\sdfsreal 32.4}{\\*\\sdfsdef 32.4}\\sdfsauto "
                + label + "\\par}\n\n}";
        int resource_text = Resource_Text.addResourceTextSql(rtf);
        int resource_image = ResourceImage.addFile(fileName, ext);
        addPage(slide_id);

        // Title
        row_id = nextRowId();
        sql = "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') "
                + "VALUES (" + Integer.toString(row_id) + "," + Integer.toString(slide_id) + ",'TITLE',6,6,"
                + NextOrder() + ",0.0199999995529652,0.0266660004854202,0.959999978542328,0.150000005960464,NULL,"
                + Integer.toString(resource_text) + ",0,1);";
        Schedule.db.executeUpdate(sql);
        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Text");
        ElementProperty.addElementProperty(epg, 5, "@mofChanged", "1");
        ElementProperty.addElementProperty(epg, 5, "@changed", "1");
        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Overrides");
        ElementProperty.addElementProperty(epg, 5, "mofText", "1");
        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Text_Format");
        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Text_Style_300");
   
        // Image
        row_id = nextRowId();
        sql = "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') "
                + "VALUES (" + Integer.toString(row_id) + "," + Integer.toString(slide_id) + ",'" + Tools.uuid()
                + "',2,0," + NextOrder() + ",-4.71347011625767e-05,0.0,1.00009429454803,1.0466103553772,NULL,"
                + Integer.toString(resource_image) + ",0,0);";
        Schedule.db.executeUpdate(sql);
        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Foreground");
        ElementProperty.addElementProperty(epg, 5, "@changed", "1");
        ElementProperty.addElementProperty(epg, 5, "@mofChanged", "1");
        
        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Overrides");
        ElementProperty.addElementProperty(epg, 5, "mofDims", "1");
        ElementProperty.addElementProperty(epg, 5, "mofForeground", "1");

        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Element");
        ElementProperty.addElementProperty(epg, 5, "@changed", "1");
        ElementProperty.addElementProperty(epg, 5, "@mofChanged", "1");
        ElementProperty.addElementProperty(epg, 5, "ConstrainDims", "1");
       }

    public void addTextPage(int slide_id, String rtf) throws SQLException {
        String sql;
        int row_id;
        int epg;
        int foreground_resource_id;
        addPage(slide_id);
        // if (rtf != "") {
        // CONTENT_SONG
        row_id = nextRowId();
        foreground_resource_id = Resource_Text.addResourceTextSql(rtf);
        sql = "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') "
                + " VALUES (" + Integer.toString(row_id) + "," + Integer.toString(slide_id) + ",'CONTENT_SONG',6,4,"
                + NextOrder() + ",0.0,0.0,1.0,1.0,NULL," + Integer.toString(foreground_resource_id) + ",0,0);";
        Schedule.db.executeUpdate(sql);
        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Text_Format"); 
        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Overrides"); 
        ElementProperty.addElementProperty(epg, 5, "mofText", "1");
        ElementProperty.addElementProperty(epg, 5, "mofDims", "1");

        // COPYRIGHT
        foreground_resource_id = Resource_Text.addResourceTextSql(
                "{\\rtf1\\ansi\\deff0\\sdeasyworship2\n\n{\\fonttbl{\\f0 Tahoma;}}\n\n{\\colortbl ;}\n\n{\\pard\\sdlistlevel0\\ql\\qdef\\plain\\fs28{\\*\\sdfsreal 14.4}{\\*\\sdfsdef 14.4}\\sdfsauto\\par}\n\n}");
        row_id = nextRowId();
        sql = "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') "
                + " VALUES (" + Integer.toString(row_id) + "," + Integer.toString(slide_id) + ",'COPYRIGHT',6,8,"
                + NextOrder() + ",0.0,0.9200000166893,1.0,0.0799999982118607,NULL,"
                + Integer.toString(foreground_resource_id) + ",0,0);";
        Schedule.db.executeUpdate(sql);
        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Text_Format");
        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Overrides");
        ElementProperty.addElementProperty(epg, 5, "mofText", "1");
//        ElementProperty.addElementProperty(epg, 5, "mofDims", "1");

        // CONTENT_SCRIPTURE
        foreground_resource_id = Resource_Text.addResourceTextSql(
                "{\\rtf1\\ansi\\deff0\\sdeasyworship2\n\n{\\fonttbl{\\f0 Tahoma;}}\n\n{\\colortbl ;}\n\n{\\pard\\sdlistlevel0\\qc\\qdef\\plain\\fs40{\\*\\sdfsreal 20}{\\*\\sdfsdef 20}\\sdfsauto\\par}\n\n}");
        row_id = nextRowId();
        sql = "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') "
                + " VALUES (" + Integer.toString(row_id) + "," + Integer.toString(slide_id)
                + ",'CONTENT_SCRIPTURE',6,5," + NextOrder() + ",0.0,0.0,1.0,1.0,NULL,"
                + Integer.toString(foreground_resource_id) + ",0,1);";
        Schedule.db.executeUpdate(sql);
        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Overrides");
        ElementProperty.addElementProperty(epg, 5, "mofText", "1");
        ElementProperty.addElementProperty(epg, 5, "mofDims", "1");
        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Text_Format");
        epg = ElementPropertyGroup.addElementPropertyGroup(row_id, "Element");
        ElementProperty.addElementProperty(epg, 5, "hidden", "1");        
    }

    public Element() throws SQLException {
        log.info("element");
        // String sql;
        // addElement(1, -1, -1, -1);
        /*
         * sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (1,1,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (2,1,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (3,1,'CONTENT_SONG',6,4,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (4,1,'COPYRIGHT',6,8,3,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (5,1,'CONTENT_SCRIPTURE',6,5,4,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql);
         */
        // addElement(2, 1, 2, 3);
        /*
         * sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (6,2,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (7,2,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (8,2,'CONTENT_SONG',6,4,2,0.0,0.0,1.0,1.0,NULL,1,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (9,2,'COPYRIGHT',6,8,3,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,2,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (10,2,'CONTENT_SCRIPTURE',6,5,4,0.0,0.0,1.0,1.0,NULL,3,0,1);"
         * ;
         */
        // addElement(3, 4, 5, 6);
        /*
         * Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (11,3,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (12,3,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (13,3,'CONTENT_SONG',6,4,2,0.0,0.0,1.0,1.0,NULL,4,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (14,3,'COPYRIGHT',6,8,3,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,5,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (15,3,'CONTENT_SCRIPTURE',6,5,4,0.0,0.0,1.0,1.0,NULL,6,0,1);"
         * ; Schedule.db.executeUpdate(sql);
         */
        /*
         * } public void elementRest() throws SQLException { sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (16,4,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (17,4,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (18,4,'CONTENT',6,1,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (19,5,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (20,5,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (21,5,'CONTENT_SONG',6,4,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (22,5,'COPYRIGHT',6,8,3,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql);
         *
         * sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (23,6,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (24,6,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (25,6,'CONTENT_SCRIPTURE',6,5,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql);
         *
         * sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (26,7,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (27,7,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (28,7,'TITLE',6,6,2,0.0199999995529652,0.0299999993294477,0.959999978542328,0.150000005960464,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (29,7,'SUBTITLE',6,7,3,0.0199999995529652,0.21000000834465,0.959999978542328,0.0750000029802322,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql); sql =
         * "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') VALUES (30,7,'CONTENT_PRESENTATION',6,3,4,0.0199999995529652,0.314999997615814,0.959999978542328,0.65499997138977,NULL,NULL,0,0);"
         * ; Schedule.db.executeUpdate(sql);
         */
    }

}