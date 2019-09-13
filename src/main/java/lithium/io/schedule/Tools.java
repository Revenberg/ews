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

import java.util.UUID;
import java.util.logging.Logger;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Random;

public class Tools {
    private static Logger log = Logger.getLogger(Tools.class.getName());
    public final static String tempDir = "./temp";

    public static File copyFile(String fileName) throws IOException {
        InputStream is = null;
        OutputStream os = null;
        try {

            File directory = new File(String.valueOf(Tools.tempDir + "/media"));
            if (!directory.exists()) {
                directory.mkdir();
            }

            try {
                // This already throws FileNotFoundException
                BufferedReader br = new BufferedReader(new FileReader("./media" + "/" + fileName));
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }

            is = new FileInputStream("./media" + "/" + fileName);
            os = new FileOutputStream(Tools.tempDir + "/media/" + fileName);
            byte[] buffer = new byte[1024];
            int length;
            while ((length = is.read(buffer)) > 0) {
                os.write(buffer, 0, length);
            }
        } finally {
            log.info(fileName + " copied.");
            is.close();
            os.close();
        }
        return new File(Tools.tempDir + "/media/" + fileName);
    }

    public synchronized static String uuid() {
        String id = UUID.randomUUID().toString().replace("-", "") + UUID.randomUUID().toString().replace("-", "");

        String uuid = id.substring(0, 1) + "-" + id.substring(2, 10) + "-" + id.substring(11, 15) + "-"
                + id.substring(16, 20) + "-" + id.substring(21, 25) + "-" + id.substring(26, 38);
        return uuid.toUpperCase();
    }

    public synchronized static String randomNumber(int length) {
        Random rand = new Random();
        String n = "";
        for (int i = 0; i < length; i++) {
            n = n + rand.nextInt(9);
        }
        return n;
    }
}