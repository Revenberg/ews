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

import java.io.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;
import java.util.ArrayList;
import java.util.List;

import java.util.logging.Logger;

/**
 * Various functions for loading, parsing and visualizing data.
 *
 * @author Sander Revenberg
 */
public class Schedule {
	private static Logger log = Logger.getLogger(Schedule.class.getName());
	public static SqliteDatabase db = new SqliteDatabase();

	public Schedule() {		
	}

/*	public void addPresentation(String title) throws SQLException {
		Presentation presentation = new Presentation(title);
		Slide slide = new Slide(presentation.getpresentation_id1(), presentation.getpresentation_id2());
		Song song = new Song();
	}
*/
	public void open(String src, String dest) throws SQLException {
		log.info("open");

		try {
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
				log.info("name: " + name);
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
		} catch (IOException e) {
			e.printStackTrace();
		}
		db.open(dest + "/main.db");

		
		db.executeUpdate("BEGIN TRANSACTION;");
		db.executeUpdate("DELETE from 'slide'");
		db.executeUpdate("DELETE from 'element'");
		db.executeUpdate("DELETE from 'presentation'");
		db.executeUpdate("DELETE from 'element_property'");		
		db.executeUpdate("DELETE from 'element_property_group'");		
		db.executeUpdate("COMMIT;");
	}

	public void close(String src, String dest) throws IOException {
		log.info("close");
		db.close();
		
			final File folder = new File(src);

			List<String> result = new ArrayList<>();

			search(".*", folder, result, "");

			FileOutputStream fos = new FileOutputStream(dest);
			ZipOutputStream zos = new ZipOutputStream(fos);

			for (String s : result) {
				log.info(s);
				addToZipFile(s, zos);
			}

			zos.close();
			fos.close();		
	}

	public static void search(final String pattern, final File folder, List<String> result, final String pre) {
		for (final File f : folder.listFiles()) {

			if (f.isDirectory()) {
				search(pattern, f, result, pre + f.getName() + "/");
			}

			if (f.isFile()) {
				if (f.getName().matches(pattern)) {
					if (pre == "") {
						result.add(f.getName());
					} else {
						result.add(pre + f.getName());
					}
				}
			}

		}
	}

	public static void addToZipFile(String fileName, ZipOutputStream zos) throws FileNotFoundException, IOException {

		System.out.println("Writing '" + fileName + "' to zip file");

		File file = new File(fileName);
		FileInputStream fis = new FileInputStream("temp/" + file);
		ZipEntry zipEntry = new ZipEntry(fileName);
		zos.putNextEntry(zipEntry);

		byte[] bytes = new byte[1024];
		int length;
		while ((length = fis.read(bytes)) >= 0) {
			zos.write(bytes, 0, length);
		}

		zos.closeEntry();
		fis.close();
	}

	public static void deleteFolder(String folder) {
		File index = new File(folder);
		if (!index.exists()) {
			index.mkdir();
		} else {
			index.delete();
			if (!index.exists()) {
				index.mkdir();
			}
		}
	}
}