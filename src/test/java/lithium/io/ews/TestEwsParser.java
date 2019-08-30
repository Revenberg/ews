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

package lithium.io.ews;

import java.io.*;
import java.nio.*;
import java.nio.charset.*;
import java.util.*;

import junit.framework.*;
import lithium.io.rtf.*;

import static lithium.io.jrtf.Rtf.rtf;
import static lithium.io.jrtf.RtfHeader.font;
import static lithium.io.jrtf.RtfPara.*;
import static lithium.io.jrtf.RtfText.*;
import static lithium.io.jrtf.RtfUnit.CM;

import java.util.logging.Logger;

/*import static lithium.io.jrtf.Rtf.rtf;
import static lithium.io.jrtf.RtfHeader.font;
import static lithium.io.jrtf.RtfPara.*;
import static lithium.io.jrtf.RtfText.*;
import static lithium.io.jrtf.RtfUnit.CM;
*/
import lithium.io.jrtf.*;

/**
 * Test case for {@link EwsParser}.
 *
 * @author Gerrit Meinders
 */
public class TestEwsParser extends TestCase {
	private static Logger log = Logger.getLogger(TestEwsParser.class.getName());

	/**
	 * Reads a schedule with 3 song entries, which contain some fragments from
	 * "Lorem Ipsum".
	 */
	private ScheduleEntry createSong() {
		RtfPara nextPar = RtfPara.p("second paragraph");

		Rtf rtf = rtf();
		rtf.header(font(RtfHeaderFont.WINDINGS).at(1));
		rtf.section(p("line1 ", 2, bold(" 3"), new Date(), text("dd"), text(true, "1", 2)), nextPar,
				row(bold("Üöäß"), bold("T")), nextPar,
				row(bold("BLABLA"), bold("T")),
				row(bold("BLABLA"), bold("T"))				
		// ,
		// row( picture( RtfDocumentDemo.class.getResource( "folder.png" ) ).type(
		// PictureType.AUTOMATIC ),
		// font(1, text("\u00fc") )
		// ).cellSpace( 1, CM )
		);
		String content = rtf.toString();
		log.info(content);

		// final ScheduleEntry entry = entries.get(3);

		ScheduleEntry scheduleEntry = new ScheduleEntry();
		scheduleEntry.setTitle("test");
		scheduleEntry.setSongNumber("000");
		scheduleEntry.setType(ScheduleEntry.Type.SCRIPTURE);

		// final Content content = entry.getContent();
		TextContent myContent = new TextContent();
		// final TextContent textContent = (TextContent) content;
		// log.info(RtfWriter.writeToString(textContent.getText()));

		RtfGroup text = new RtfGroup();

		ControlWord node = new ControlWord();
		node.setWord(content);
		text.addNode(node);

		myContent.setText(text);
		scheduleEntry.setContent(myContent);

		return scheduleEntry;
	}

	public void testSongs() throws IOException {
		log.info("I'm starting");
		final byte[] scheduleFile = Tools.loadResource(getClass(), "lorem.ews");

		final EwsParser parser = new EwsParser();
		parser.setCharset(Charset.forName("windows-1252"));
		Schedule schedule = parser.parse(ByteBuffer.wrap(scheduleFile));

		// TODO: It's not an exact match yet, due to a timestamp rounding issue and
		// slightly different compression of the content.
		// assertEquals( "Unexpected output.", Arrays.toString( scheduleFile ),
		// Arrays.toString( output ) );

		// Reading back the output should be enough verification for now:
		// parser.parse( ByteBuffer.wrap( output ) );

		final List<ScheduleEntry> playlistEntries = schedule.getEntries();

		playlistEntries.add(createSong());

		final ByteArrayOutputStream out = new ByteArrayOutputStream();
		final EwsWriter writer = new EwsWriter(out);
		writer.setCharset(Charset.forName("windows-1252"));
		writer.write(schedule);
		final byte[] output = out.toByteArray();
		try {
			FileOutputStream fos = new FileOutputStream("c:\\temp\\lorem.ews");
			fos.write(output);
			fos.close();
		} catch (IOException ex) {
			System.out.println(ex);
		}

		final List<ScheduleEntry> entries = schedule.getEntries();
		assertEquals("Unexpected number of entries.", 4, entries.size());

		final String[] expectedTitles = { "Lorem 1", "Lorem 2", "Lorem 3", "test", };

		final String[] expectedContents = {
				"{\\rtf1\\ansi\\deff0\\deftab254{\\fonttbl{\\f0\\fnil\\fcharset1 Arial;}}{\\colortbl\\red0\\green0\\blue0;\\red255\\green0\\blue0;\\red0\\green128\\blue0;\\red0\\green0\\blue255;\\red255\\green255\\blue0;\\red255\\green0\\blue255;\\red128\\green0\\blue128;\\red128\\green0\\blue0;\\red0\\green255\\blue0;\\red0\\green255\\blue255;\\red0\\green128\\blue128;\\red0\\green0\\blue128;\\red255\\green255\\blue255;\\red192\\green192\\blue192;\\red128\\green128\\blue128;\\red255\\green255\\blue255;}\\paperw12240\\paperh15840\\margl1880\\margr1880\\margt1440\\margb1440{\\*\\pnseclvl1\\pnucrm\\pnstart1\\pnhang\\pnindent720{\\pntxtb}{\\pntxta{.}}}\r\n"
						+ "{\\*\\pnseclvl2\\pnucltr\\pnstart1\\pnhang\\pnindent720{\\pntxtb}{\\pntxta{.}}}\r\n"
						+ "{\\*\\pnseclvl3\\pndec\\pnstart1\\pnhang\\pnindent720{\\pntxtb}{\\pntxta{.}}}\r\n"
						+ "{\\*\\pnseclvl4\\pnlcltr\\pnstart1\\pnhang\\pnindent720{\\pntxtb}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl5\\pndec\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl6\\pnlcltr\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl7\\pnlcrm\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl8\\pnlcltr\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl9\\pndec\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\pard\\ql\\li0\\fi0\\ri0\\sb0\\sl\\sa0 \\plain\\f1\\fs18\\fntnamaut Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lobortis \\plain\\f1\\fs18\\fntnamaut eros a risus volutpat tempus. Sed id massa non mauris egestas porta bibendum \\plain\\f1\\fs18\\fntnamaut quis eros. Etiam adipiscing ipsum magna, sed iaculis justo tincidunt ut. Vivamus \\plain\\f1\\fs18\\fntnamaut eget velit augue. Phasellus aliquet pretium interdum. Aenean molestie, neque \\plain\\f1\\fs18\\fntnamaut eget placerat cursus, quam sem tristique lorem, ac venenatis tellus velit sit amet \\plain\\f1\\fs18\\fntnamaut neque. Integer et mauris vitae dui lobortis cursus volutpat vitae justo. Nunc vitae \\plain\\f1\\fs18\\fntnamaut lorem non ipsum rutrum sodales nec eget mauris. Quisque molestie tristique \\plain\\f1\\fs18\\fntnamaut laoreet. Pellentesque gravida convallis elit in pretium. Fusce non augue neque. \\plain\\f1\\fs18\\fntnamaut Duis at dolor justo. Nunc ac tellus a nibh tristique euismod nec quis nunc.\\par\r\n"
						+ "\\ql\\li0\\fi0\\ri0\\sb0\\sl\\sa0 \\plain\\f1\\fs18\\fntnamaut }\r\n" + "}",

				"{\\rtf1\\ansi\\deff0\\deftab254{\\fonttbl{\\f0\\fnil\\fcharset1 Arial;}}{\\colortbl\\red0\\green0\\blue0;\\red255\\green0\\blue0;\\red0\\green128\\blue0;\\red0\\green0\\blue255;\\red255\\green255\\blue0;\\red255\\green0\\blue255;\\red128\\green0\\blue128;\\red128\\green0\\blue0;\\red0\\green255\\blue0;\\red0\\green255\\blue255;\\red0\\green128\\blue128;\\red0\\green0\\blue128;\\red255\\green255\\blue255;\\red192\\green192\\blue192;\\red128\\green128\\blue128;\\red255\\green255\\blue255;}\\paperw12240\\paperh15840\\margl1880\\margr1880\\margt1440\\margb1440{\\*\\pnseclvl1\\pnucrm\\pnstart1\\pnhang\\pnindent720{\\pntxtb}{\\pntxta{.}}}\r\n"
						+ "{\\*\\pnseclvl2\\pnucltr\\pnstart1\\pnhang\\pnindent720{\\pntxtb}{\\pntxta{.}}}\r\n"
						+ "{\\*\\pnseclvl3\\pndec\\pnstart1\\pnhang\\pnindent720{\\pntxtb}{\\pntxta{.}}}\r\n"
						+ "{\\*\\pnseclvl4\\pnlcltr\\pnstart1\\pnhang\\pnindent720{\\pntxtb}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl5\\pndec\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl6\\pnlcltr\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl7\\pnlcrm\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl8\\pnlcltr\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl9\\pndec\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\pard\\ql\\li0\\fi0\\ri0\\sb0\\sl\\sa0 \\plain\\f1\\fs18\\fntnamaut Suspendisse consequat ligula et elementum facilisis. Etiam in sollicitudin nisi, \\plain\\f1\\fs18\\fntnamaut ullamcorper faucibus mi. Mauris justo odio, consectetur id tempus ac, interdum \\plain\\f1\\fs18\\fntnamaut ut mauris. Etiam non ligula semper, accumsan tellus vitae, ultricies tellus. Nam \\plain\\f1\\fs18\\fntnamaut dignissim, arcu porta pretium tincidunt, dui arcu dapibus ligula, non ultricies \\plain\\f1\\fs18\\fntnamaut nulla nisi et tellus. Nam non tempus diam, in tempus orci. Nulla congue lobortis \\plain\\f1\\fs18\\fntnamaut interdum.\\par\r\n"
						+ "\\ql\\li0\\fi0\\ri0\\sb0\\sl\\sa0 \\plain\\f1\\fs18\\fntnamaut }\r\n" + "}",

				"{\\rtf1\\ansi\\deff0\\deftab254{\\fonttbl{\\f0\\fnil\\fcharset1 Arial;}}{\\colortbl\\red0\\green0\\blue0;\\red255\\green0\\blue0;\\red0\\green128\\blue0;\\red0\\green0\\blue255;\\red255\\green255\\blue0;\\red255\\green0\\blue255;\\red128\\green0\\blue128;\\red128\\green0\\blue0;\\red0\\green255\\blue0;\\red0\\green255\\blue255;\\red0\\green128\\blue128;\\red0\\green0\\blue128;\\red255\\green255\\blue255;\\red192\\green192\\blue192;\\red128\\green128\\blue128;\\red255\\green255\\blue255;}\\paperw12240\\paperh15840\\margl1880\\margr1880\\margt1440\\margb1440{\\*\\pnseclvl1\\pnucrm\\pnstart1\\pnhang\\pnindent720{\\pntxtb}{\\pntxta{.}}}\r\n"
						+ "{\\*\\pnseclvl2\\pnucltr\\pnstart1\\pnhang\\pnindent720{\\pntxtb}{\\pntxta{.}}}\r\n"
						+ "{\\*\\pnseclvl3\\pndec\\pnstart1\\pnhang\\pnindent720{\\pntxtb}{\\pntxta{.}}}\r\n"
						+ "{\\*\\pnseclvl4\\pnlcltr\\pnstart1\\pnhang\\pnindent720{\\pntxtb}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl5\\pndec\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl6\\pnlcltr\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl7\\pnlcrm\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl8\\pnlcltr\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\*\\pnseclvl9\\pndec\\pnstart1\\pnhang\\pnindent720{\\pntxtb{(}}{\\pntxta{)}}}\r\n"
						+ "{\\pard\\ql\\li0\\fi0\\ri0\\sb0\\sl\\sa0 \\plain\\f1\\fs18\\fntnamaut Suspendisse scelerisque mauris eget interdum hendrerit. Fusce aliquam est id \\plain\\f1\\fs18\\fntnamaut lorem pellentesque, non euismod lacus pellentesque. Nulla facilisi. Nullam \\plain\\f1\\fs18\\fntnamaut ornare pharetra condimentum. Nulla interdum ornare placerat. Phasellus vel \\plain\\f1\\fs18\\fntnamaut lorem sapien. Suspendisse at varius mauris, a ultricies massa. Nullam rhoncus \\plain\\f1\\fs18\\fntnamaut ultricies nunc eget aliquam. Fusce faucibus rhoncus euismod. Cras in hendrerit \\plain\\f1\\fs18\\fntnamaut lectus, id vehicula tellus. Phasellus porta nisi accumsan sapien imperdiet, vel \\plain\\f1\\fs18\\fntnamaut suscipit est porttitor. Nam adipiscing dolor vel ligula vulputate, accumsan \\plain\\f1\\fs18\\fntnamaut blandit erat aliquam. Quisque sodales porta dignissim.\\par\r\n"
						+ "\\ql\\li0\\fi0\\ri0\\sb0\\sl\\sa0 \\plain\\f1\\fs18\\fntnamaut }\r\n" + "}", };

		for (int i = 0; i < 3; i++) {
			final ScheduleEntry entry = entries.get(i);
			assertEquals("Entry " + i + ": unexpected title.", expectedTitles[i], entry.getTitle());

			final Content content = entry.getContent();
			assertTrue("Expected text content, but was: " + content, content instanceof TextContent);

			final TextContent textContent = (TextContent) content;
			assertEquals("Entry " + i + ": unexpected content.", expectedContents[i],
					RtfWriter.writeToString(textContent.getText()));
			log.info(RtfWriter.writeToString(textContent.getText()));
		}
		final ScheduleEntry entry = entries.get(3);
		final Content content = entry.getContent();
		final TextContent textContent = (TextContent) content;
		log.info(RtfWriter.writeToString(textContent.getText()));
	}
}