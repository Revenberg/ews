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

public class Slide {
        private static Logger log = Logger.getLogger(Slide.class.getName());
        private int rowid = 0;
        private int order = 0;
        private Element element = new Element();

        public Element getElement() {
                return element;
        }

        private int nextRowId() {
                if (rowid == 0) {
                        rowid = SqliteDatabase.getMaxRowId("slide");
                }
                rowid = rowid + 1;
                return rowid;
        }

        public int addMaster(int presentation_id2) throws SQLException {
                String sql;
                sql = "INSERT INTO 'slide' ('rowid','presentation_id','title','slide_uid','slide_rev_uid','order_index','layout_flag','theme_id','theme_slide_uid','modified_theme_id','modified_theme_layout_revision','layout_revision','thumbnail_desired_rev','thumbnail_rev','thumbnail')"
                                + " VALUES (" + Integer.toString(nextRowId()) + "," + Integer.toString(presentation_id2)
                                + ",'Master','MASTER',NULL,0,2083,NULL,'SONG',NULL,NULL," + Tools.randomNumber(19) + ","
                                + Tools.randomNumber(19) + "," + Tools.randomNumber(19) + ",NULL);";
                SqliteDatabase.executeUpdate(sql);
                return rowid;
        }

        public int addSlide(int presentation_id, int layout_flag) throws SQLException {
                String sql;
                String id = Tools.randomNumber(19);
                sql = "INSERT INTO 'slide' ('rowid','presentation_id','title','slide_uid','slide_rev_uid','order_index','layout_flag','theme_id','theme_slide_uid','modified_theme_id','modified_theme_layout_revision','layout_revision','thumbnail_desired_rev','thumbnail_rev','thumbnail')"
                                + " VALUES (" + Integer.toString(nextRowId()) + "," + Integer.toString(presentation_id)
                                + ",'','" + Tools.uuid() + "',NULL," + Integer.toString(order)
                                + ","+Integer.toString(layout_flag)+",2,'MASTER',NULL,NULL," + Tools.randomNumber(19) + "," + id + "," + id
                                + ",NULL);";
                SqliteDatabase.executeUpdate(sql);
                order++;
                return rowid;
        }

        public int addSlideImage(int presentation_id) throws SQLException {
                String sql;
                String id = Tools.randomNumber(19);
                sql = "INSERT INTO 'slide' ('rowid','presentation_id','title','slide_uid','slide_rev_uid','order_index','layout_flag','theme_id','theme_slide_uid','modified_theme_id','modified_theme_layout_revision','layout_revision','thumbnail_desired_rev','thumbnail_rev','thumbnail') "
                                + "VALUES (" + Integer.toString(nextRowId()) + "," + Integer.toString(presentation_id)
                                + ",'','" + Tools.uuid() + "',NULL," + Integer.toString(order)
                                + ",3,2,'BLANK',NULL,NULL," + Tools.randomNumber(19)
                                + "," + id + "," + id + ",NULL);";
                SqliteDatabase.executeUpdate(sql);
                order++;
                return rowid;
        }

        public Slide() throws SQLException {
                log.info("slide");

                /*
                 * sql =
                 * "INSERT INTO 'slide' ('rowid','presentation_id','title','slide_uid','slide_rev_uid','order_index','layout_flag','theme_id','theme_slide_uid','modified_theme_id','modified_theme_layout_revision','layout_revision','thumbnail_desired_rev','thumbnail_rev','thumbnail')"
                 * + " VALUES (" + Integer.toString(nextRowId()) + "," +
                 * Integer.toString(presentation_id2) +
                 * ",'Master','MASTER',NULL,0,2083,NULL,'SONG',NULL,NULL," +
                 * Tools.randomNumber(19) + "," + Tools.randomNumber(19) + "," +
                 * Tools.randomNumber(19) + ",NULL);"; SqliteDatabase.executeUpdate(sql);
                 */
                // addMaster(presentation_id2);
                /*
                 * id = Tools.randomNumber(19); sql =
                 * "INSERT INTO 'slide' ('rowid','presentation_id','title','slide_uid','slide_rev_uid','order_index','layout_flag','theme_id','theme_slide_uid','modified_theme_id','modified_theme_layout_revision','layout_revision','thumbnail_desired_rev','thumbnail_rev','thumbnail')"
                 * + " VALUES (" + Integer.toString(nextRowId()) + "," +
                 * Integer.toString(presentation_id1) + ",'','" + Tools.uuid() +
                 * "',NULL,0,2083,2,'MASTER',NULL,NULL," + Tools.randomNumber(19) + "," + id +
                 * "," + id + ",NULL);"; SqliteDatabase.executeUpdate(sql); id =
                 * Tools.randomNumber(19); sql =
                 * "INSERT INTO 'slide' ('rowid','presentation_id','title','slide_uid','slide_rev_uid','order_index','layout_flag','theme_id','theme_slide_uid','modified_theme_id','modified_theme_layout_revision','layout_revision','thumbnail_desired_rev','thumbnail_rev','thumbnail')"
                 * + " VALUES (" + Integer.toString(nextRowId()) + "," +
                 * Integer.toString(presentation_id1) + ",'','" + Tools.uuid() +
                 * "',NULL,1,2083,2,'MASTER',NULL,NULL," + Tools.randomNumber(19) + "," + id +
                 * "," + id + ",NULL);"; SqliteDatabase.executeUpdate(sql);
                 */
                // addSlide(presentation_id1);
                // addSlide(presentation_id1);
                /*
                 * id = Tools.randomNumber(19); sql =
                 * "INSERT INTO 'slide' ('rowid','presentation_id','title','slide_uid','slide_rev_uid','order_index','layout_flag','theme_id','theme_slide_uid','modified_theme_id','modified_theme_layout_revision','layout_revision','thumbnail_desired_rev','thumbnail_rev','thumbnail')"
                 * + " VALUES (" + Integer.toString(nextRowId()) + "," +
                 * Integer.toString(presentation_id3) +
                 * ",'Master','MASTER',NULL,0,19,NULL,'',NULL,NULL," + Tools.randomNumber(19) +
                 * "," + id + "," + id + ",NULL);"; SqliteDatabase.executeUpdate(sql); id =
                 * Tools.randomNumber(19); sql =
                 * "INSERT INTO 'slide' ('rowid','presentation_id','title','slide_uid','slide_rev_uid','order_index','layout_flag','theme_id','theme_slide_uid','modified_theme_id','modified_theme_layout_revision','layout_revision','thumbnail_desired_rev','thumbnail_rev','thumbnail')"
                 * + " VALUES (" + Integer.toString(nextRowId()) + "," +
                 * Integer.toString(presentation_id3) +
                 * ",'Song','SONG',NULL,1,2083,NULL,'MASTER',NULL,NULL," +
                 * Tools.randomNumber(19) + "," + id + "," + id + ",NULL);";
                 * SqliteDatabase.executeUpdate(sql); id = Tools.randomNumber(19); sql =
                 * "INSERT INTO 'slide' ('rowid','presentation_id','title','slide_uid','slide_rev_uid','order_index','layout_flag','theme_id','theme_slide_uid','modified_theme_id','modified_theme_layout_revision','layout_revision','thumbnail_desired_rev','thumbnail_rev','thumbnail')"
                 * + " VALUES (" + Integer.toString(nextRowId()) + "," +
                 * Integer.toString(presentation_id3) +
                 * ",'Scripture','SCRIPTURE',NULL,2,67,NULL,'MASTER',NULL,NULL," +
                 * Tools.randomNumber(19) + "," + id + "," + id + ",NULL);";
                 * SqliteDatabase.executeUpdate(sql); id = Tools.randomNumber(19); sql =
                 * "INSERT INTO 'slide' ('rowid','presentation_id','title','slide_uid','slide_rev_uid','order_index','layout_flag','theme_id','theme_slide_uid','modified_theme_id','modified_theme_layout_revision','layout_revision','thumbnail_desired_rev','thumbnail_rev','thumbnail')"
                 * + " VALUES (" + Integer.toString(nextRowId()) + "," +
                 * Integer.toString(presentation_id3) +
                 * ",'Presentation','PRESENTATION',NULL,3,143,NULL,'MASTER',NULL,NULL," +
                 * Tools.randomNumber(19) + "," + id + "," + id + ",NULL);";
                 * SqliteDatabase.executeUpdate(sql);
                 */
        }

}