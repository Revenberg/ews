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
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Random;

public class Tools {
    private static Logger log = Logger.getLogger(Tools.class.getName());
    public final static String tempDir = "d:/tmp";

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

    /**
     * Utility method to save InputStream data to target location/file
     * 
     * @param inStream - InputStream to be saved
     * @param target   - full path to destination file
     */
    public static void saveToFile(InputStream inStream, String target) throws IOException {
        OutputStream out = null;
        int read = 0;
        byte[] bytes = new byte[1024];
        out = new FileOutputStream(new File(target));
        while ((read = inStream.read(bytes)) != -1) {
            out.write(bytes, 0, read);
        }
        out.flush();
        out.close();
    }

    /**
     * Creates a folder to desired location if it not already exists
     * 
     * @param dirName - full path to the folder
     * @throws SecurityException - in case you don't have permission to create the
     *                           folder
     */
    public static void createFolderIfNotExists(String dirName) throws SecurityException {
        File theDir = new File(dirName);
        if (!theDir.exists()) {
            theDir.mkdir();
        }

    }

    public static List<String> unzip(String src, String dest) throws IOException {
        List<String> rc = new ArrayList<String>();
        ZipFile zipFile = new ZipFile(src);
        Enumeration<?> enu = zipFile.entries();
        while (enu.hasMoreElements()) {
            ZipEntry zipEntry = (ZipEntry) enu.nextElement();

            String name = dest + "/" + zipEntry.getName();
            // long size = zipEntry.getSize();
            // long compressedSize = zipEntry.getCompressedSize();
            // log.info("name: %-20s | size: %6d | compressed size: %6d\n",
            // name, size, compressedSize);

            File file = new File(name);
            // log.info("name: " + name);
            rc.add(name);
            if (name.endsWith("/")) {
                file.mkdirs();
                continue;
            }

            File parent = file.getParentFile();
            if (parent != null) {
                parent.mkdirs();
            }

            InputStream is = zipFile.getInputStream(zipEntry);
            FileOutputStream fos = new FileOutputStream(file);
            byte[] bytes = new byte[1024];
            int length;
            while ((length = is.read(bytes)) >= 0) {
                fos.write(bytes, 0, length);
            }
            is.close();
            fos.close();
        }
        zipFile.close();
        return rc;
    }
}