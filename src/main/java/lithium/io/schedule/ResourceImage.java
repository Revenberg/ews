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

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.logging.Logger;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.FileImageInputStream;
import javax.imageio.stream.ImageInputStream;

public class ResourceImage {
    private static Logger log = Logger.getLogger(ResourceImage.class.getName());
    private static int rowid = 0;

    private static int nextRowId() {
        if (rowid == 0) {
            rowid = Schedule.db.getMaxRowId("resource_image");
        }
        rowid = rowid + 1;
        return rowid;
    }

    public static int addFile(String fileName, String ext) throws SQLException, IOException {
        File file = Tools.copyFile(fileName + ext);
        int filenr = DbFile.addFile(fileName + ext);        
                
        int width = 0;
        int height =0;
        
        Iterator<ImageReader> iter = ImageIO.getImageReadersBySuffix(ext.replace(".", ""));
        while(iter.hasNext()) {
          ImageReader reader = iter.next();
            ImageInputStream stream = new FileImageInputStream(file);
            reader.setInput(stream);
            width = reader.getWidth(reader.getMinIndex());
            height = reader.getHeight(reader.getMinIndex());
            reader.dispose();
          }
              
        int resource_id = Resource.addResource(2, fileName);        

        String sql = "INSERT INTO 'resource_image' ('rowid','resource_id','file_id','original_filename','filesize','modified_date','width','height') "
                + "VALUES (" + Integer.toString(nextRowId()) + "," + Integer.toString(resource_id) + "," + Integer.toString(filenr) + ",'<images>"
                + fileName + "'," + Long.toString(file.length()) + ", " + Long.toString(file.lastModified())
                + "," +Integer.toString(width) +"," +Integer.toString(height) +");";
                Schedule.db.executeUpdate(sql);
        return resource_id;
    }

    public ResourceImage() {
    }
}