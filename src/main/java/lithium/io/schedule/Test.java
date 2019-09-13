package lithium.io.schedule;

import java.sql.SQLException;

public class Test {
    public Test(int presentation_id, int slide_id) throws SQLException {

        String id = Tools.randomNumber(9);
     //   int slide_id = 7;
        int resource_id1 = 1;
        int resource_id2 = 2;
        String label = "vers 1a";
        String fileName = "testfile";
        String ext = ".png";

        /*
         * SqliteDatabase.executeUpdate(
         * "INSERT INTO 'slide' ('rowid','presentation_id','title','slide_uid','slide_rev_uid','order_index','layout_flag','theme_id','theme_slide_uid','modified_theme_id','modified_theme_layout_revision','layout_revision','thumbnail_desired_rev','thumbnail_rev','thumbnail') "
         * + "VALUES (" + Integer.toString(slide_id) + "," +
         * Integer.toString(presentation_id) + ",'','" + Tools.uuid() +
         * "',NULL,0,3,2,'BLANK',NULL,NULL," + Tools.randomNumber(19) + "," + id + "," +
         * id + ",NULL);");
         */
        SqliteDatabase.executeUpdate(
                "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') "
                        + "VALUES (23," + Integer.toString(slide_id)
                        + ",'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);");
        SqliteDatabase.executeUpdate(
                "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') " + "VALUES (23,25,'Text');");
        SqliteDatabase.executeUpdate("INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') "
                + "VALUES (23,23,5,'@mofChanged','1');");
        SqliteDatabase.executeUpdate("INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') "
                + "VALUES (24,23,5,'@changed','1');");

        SqliteDatabase.executeUpdate(
                "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') "
                        + "VALUES (24," + Integer.toString(slide_id)
                        + ",'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);");
        SqliteDatabase.executeUpdate(
                "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') "
                        + "VALUES (25," + Integer.toString(slide_id)
                        + ",'TITLE',6,6,2,0.0199999995529652,0.0266660004854202,0.959999978542328,0.150000005960464,NULL,1,0,1);");
        SqliteDatabase.executeUpdate("INSERT INTO 'element_property_group' ('rowid','link_id','group_name') "
                + "VALUES (24,25,'Overrides');");
        SqliteDatabase.executeUpdate("INSERT INTO 'element_property_group' ('rowid','link_id','group_name') "
                + "VALUES (25,25,'Text_Format');");
        SqliteDatabase.executeUpdate("INSERT INTO 'element_property_group' ('rowid','link_id','group_name') "
                + "VALUES (26,25,'Text_Style_300');");

        SqliteDatabase.executeUpdate(
                "INSERT INTO 'element' ('rowid','slide_id','element_uid','element_type','element_style_type','order_index','x','y','width','height','background_resource_id','foreground_resource_id','internal_mute','from_master') "
                        + "VALUES (26," + Integer.toString(slide_id) + ",'" + Tools.uuid()
                        + "',2,0,3,-4.71347011625767e-05,0.0,1.00009429454803,1.0466103553772,NULL,2,0,0);");
        SqliteDatabase.executeUpdate("INSERT INTO 'element_property_group' ('rowid','link_id','group_name') "
                + "VALUES (27,26,'Foreground');");
        SqliteDatabase.executeUpdate("INSERT INTO 'element_property_group' ('rowid','link_id','group_name') "
                + "VALUES (28,26,'Overrides');");
        SqliteDatabase.executeUpdate(
                "INSERT INTO 'element_property_group' ('rowid','link_id','group_name') " + "VALUES (29,26,'Element');");

        SqliteDatabase.executeUpdate("INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') "
                + "VALUES (26,27,5,'@changed','1');");
        SqliteDatabase.executeUpdate("INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') "
                + "VALUES (27,27,5,'@mofChanged','1');");
        SqliteDatabase.executeUpdate("INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') "
                + "VALUES (28,27,5,'Interactive','1');");
        SqliteDatabase.executeUpdate("INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') "
                + "VALUES (29,28,5,'mofDims','1');");
        SqliteDatabase.executeUpdate("INSERT INTO 'element_property' ('rowid','group_id','value_type','key','value') "
                + "VALUES (30,28,5,'mofForeground','1');");

        SqliteDatabase.executeUpdate(
                "INSERT INTO 'resource' ('rowid','resource_hash','resource_uid','resource_type','title','author','copyright','description','tags') "
                        + "VALUES (" + Integer.toString(resource_id1) + "," + Tools.randomNumber(19) + ",'"
                        + Tools.uuid() + "',6,'','','','','');");
        SqliteDatabase.executeUpdate("INSERT INTO 'resource_text' ('rowid','resource_id','rtf') " + "VALUES (1,"
                + Integer.toString(resource_id1)
                + ",'{\\rtf1\\ansi\\deff0\\sdeasyworship2\n\n{\\fonttbl{\\f0 Tahoma;}}\n\n{\\colortbl ;}\n\n{\\pard\\sdlistlevel-1\\qc\\qdef\\sdewparatemplatestyle300{\\*\\sdasfactor 1}{\\*\\sdasbaseline 32.4}\\sdastextstyle300\\plain\\sdewtemplatestyle300\\fs64{\\*\\sdfsreal 32.4}{\\*\\sdfsdef 32.4}\\sdfsauto "
                + label + "\\par}\n\n}');");

        SqliteDatabase.executeUpdate(
                "INSERT INTO 'resource' ('rowid','resource_hash','resource_uid','resource_type','title','author','copyright','description','tags') "
                        + "VALUES (" + Integer.toString(resource_id2) + ",NULL,'" + Tools.uuid()
                        + "',2,'fileName1','','','','');");
        SqliteDatabase.executeUpdate(
                "INSERT INTO 'resource_image' ('rowid','resource_id','file_id','original_filename','filesize','modified_date','width','height') "
                        + "VALUES (1," + Integer.toString(resource_id2) + ",1,'<images>" + fileName + ext
                        + "',42694,119600028000000016,1744,1216);");
        SqliteDatabase.executeUpdate("INSERT INTO 'file' ('rowid','file_hash','filename','shared_filename') " + ""
                + "VALUES (1,NULL,'" + fileName + ext + "',NULL);");

    }
}