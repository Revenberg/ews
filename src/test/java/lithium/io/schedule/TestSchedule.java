/*
 * Copyright 2013-2014 Gerrit Meinders
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

import junit.framework.TestCase;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

/**
 * Test case for {@link EwsParser}.
 *
 * @author Gerrit Meinders
 */
public class TestSchedule extends TestCase {
	/**
	 *
	 */

	private static Logger log = Logger.getLogger(TestSchedule.class.getName());

	public void testSongs() throws SQLException, IOException {
		Schedule.deleteFolder(Tools.tempDir);
		String rtf;
		
		Schedule schedule = new Schedule();

		schedule.open("./empty.ewsx", Tools.tempDir);
			
		Presentation presentation1 = new Presentation(6, "mijn test");		
		Presentation presentation0 = new Presentation(13, "Blank");		

		Presentation presentationImage = new Presentation(8, "mijn testje");		
		String fileName = "testfile";
        String ext = ".png";
		
//		int slide_id = slideImage.addSlide(presentationImage.getpresentation_id());

//		Test test = new Test(presentationImage.getpresentation_id(),slide_id);

		//Presentation presentation4 = new Presentation(11, "Global");
		Presentation presentation2 = new Presentation(8, "lied 2");		
		Presentation presentation3 = new Presentation(8, "lied 3");		
		Presentation presentation4 = new Presentation(8, "lied 4");		
		
		Slide slide0 = new Slide();
		slide0.addMaster(presentation0.getpresentation_id());

		Slide slideImage = new Slide();		
		for (int i=1; i < 8; i++ ) {
			slideImage.getElement().addImagePage(slideImage.addSlide(presentationImage.getpresentation_id(),0), "Vers " + Integer.toString(i), fileName, ext);
				}

		Slide slide1 = new Slide();		
		for (int i=1; i < 4; i++ ) {
			rtf = "{\\rtf1\\ansi\\deff0\\sdeasyworship2\n\n{\\fonttbl{\\f0 Tahoma;}}\n\n{\\colortbl ;}\n\n{\\pard\\sdparawysiwghidden\\sdlistlevel-1\\qc\\qdef\\sdewparatemplatestyle102\\plain\\sdewtemplatestyle102\\fs64{\\*\\sdfsreal 32.4}{\\*\\sdfsdef 32.4}\\sdfsauto Label " + Integer.toString(i) +"\\par}\n\n{\\pard\\sdlistlevel0\\qc\\qdef\\sdewparatemplatestyle101{\\*\\sdasfactor 1}{\\*\\sdasbaseline 32.4}\\sdastextstyle101\\plain\\sdewtemplatestyle101\\fs64{\\*\\sdfsreal 32.4}{\\*\\sdfsdef 32.4}\\sdfsauto Song " + Integer.toString(i) +"\\par}\n\n}";
			slide1.getElement().addTextPage(slide1.addSlide(presentation1.getpresentation_id(),2083), rtf);
		}
		
		Slide slide2 = new Slide();		
		for (int i=1; i < 3; i++ ) {
			rtf = "{\\rtf1\\ansi\\deff0\\sdeasyworship2\n\n{\\fonttbl{\\f0 Tahoma;}}\n\n{\\colortbl ;}\n\n{\\pard\\sdparawysiwghidden\\sdlistlevel-1\\qc\\qdef\\sdewparatemplatestyle102\\plain\\sdewtemplatestyle102\\fs64{\\*\\sdfsreal 32.4}{\\*\\sdfsdef 32.4}\\sdfsauto Label " + Integer.toString(i) +"\\par}\n\n{\\pard\\sdlistlevel0\\qc\\qdef\\sdewparatemplatestyle101{\\*\\sdasfactor 1}{\\*\\sdasbaseline 32.4}\\sdastextstyle101\\plain\\sdewtemplatestyle101\\fs64{\\*\\sdfsreal 32.4}{\\*\\sdfsdef 32.4}\\sdfsauto Song " + Integer.toString(i) +"\\par}\n\n}";
			slide2.getElement().addTextPage(slide2.addSlide(presentation2.getpresentation_id(),2083), rtf);
		}

		Slide slide3 = new Slide();
		for (int i = 1; i < 6; i++) {
			rtf = "{\\rtf1\\ansi\\deff0\\sdeasyworship2\n\n{\\fonttbl{\\f0 Tahoma;}}\n\n{\\colortbl ;}\n\n{\\pard\\sdparawysiwghidden\\sdlistlevel-1\\qc\\qdef\\sdewparatemplatestyle102\\plain\\sdewtemplatestyle102\\fs64{\\*\\sdfsreal 32.4}{\\*\\sdfsdef 32.4}\\sdfsauto Label "
					+ Integer.toString(i)
					+ "\\par}\n\n{\\pard\\sdlistlevel0\\qc\\qdef\\sdewparatemplatestyle101{\\*\\sdasfactor 1}{\\*\\sdasbaseline 32.4}\\sdastextstyle101\\plain\\sdewtemplatestyle101\\fs64{\\*\\sdfsreal 32.4}{\\*\\sdfsdef 32.4}\\sdfsauto Song "
					+ Integer.toString(i) + "\\par}\n\n}";
					slide3.getElement().addTextPage(slide3.addSlide(presentation3.getpresentation_id(), 2083), rtf);
		}

		Slide slide4 = new Slide();
		for (int i = 1; i < 5; i++) {
			rtf = "{\\rtf1\\ansi\\deff0\\sdeasyworship2\n\n{\\fonttbl{\\f0 Tahoma;}}\n\n{\\colortbl ;}\n\n{\\pard\\sdparawysiwghidden\\sdlistlevel-1\\qc\\qdef\\sdewparatemplatestyle102\\plain\\sdewtemplatestyle102\\fs64{\\*\\sdfsreal 32.4}{\\*\\sdfsdef 32.4}\\sdfsauto Label "
					+ Integer.toString(i)
					+ "\\par}\n\n{\\pard\\sdlistlevel0\\qc\\qdef\\sdewparatemplatestyle101{\\*\\sdasfactor 1}{\\*\\sdasbaseline 32.4}\\sdastextstyle101\\plain\\sdewtemplatestyle101\\fs64{\\*\\sdfsreal 32.4}{\\*\\sdfsdef 32.4}\\sdfsauto Song "
					+ Integer.toString(i) + "\\par}\n\n}";
					slide4.getElement().addTextPage(slide4.addSlide(presentation4.getpresentation_id(), 2083), rtf);
		}

		schedule.close(Tools.tempDir, "new.ewsx");

		// Tools.deleteFolder(Tools.tempDir);


	}

	public static void main(String[] args) throws SQLException, IOException {
		TestSchedule test = new TestSchedule();
		test.testSongs();
	}
}