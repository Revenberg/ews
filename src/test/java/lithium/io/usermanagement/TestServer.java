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

package lithium.io.usermanagement;

import junit.framework.TestCase;

import static org.junit.Assert.assertEquals;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.sql.SQLException;
import java.util.Scanner;
import java.util.logging.Logger;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;
/*import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.util.Date;
import java.util.List;


import junit.framework.TestCase;
/*import static lithium.io.jrtf.Rtf.rtf;
import static lithium.io.jrtf.RtfHeader.font;
import static lithium.io.jrtf.RtfPara.*;
import static lithium.io.jrtf.RtfText.*;
import static lithium.io.jrtf.RtfUnit.CM;

import lithium.io.jrtf.Rtf;
import lithium.io.jrtf.RtfHeaderFont;
import lithium.io.jrtf.RtfPara;
import lithium.io.jrtf.RtfText;
import lithium.io.rtf.ControlWord;
import lithium.io.rtf.RtfGroup;
import lithium.io.rtf.RtfWriter;

import lithium.io.schedule.*;

/*import java.io.*;
import java.nio.*;
import java.nio.charset.*;
import java.util.*;

import junit.framework.*;
import lithium.io.rtf.*;

/*import static lithium.io.jrtf.Rtf.rtf;
import static lithium.io.jrtf.RtfHeader.font;
import static lithium.io.jrtf.RtfPara.*;
import static lithium.io.jrtf.RtfText.*;
import static lithium.io.jrtf.RtfUnit.CM;
import lithium.io.jrtf.*;
*/

import org.eclipse.jetty.http.HttpStatus;
import org.junit.Test;

/**
 * Test case for {@link EwsParser}.
 *
 * @author Sander Revenberg
 */
public class TestServer {
    /**
     *
     */

    private static Logger log = Logger.getLogger(TestServer.class.getName());
    private final String USER_AGENT = "Mozilla/5.0";

    private String responseMSG;
    private int responseCode;

    private void sendGet(String url) throws Exception {

        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();

        // optional default is GET
        con.setRequestMethod("GET");

        // add request header
        con.setRequestProperty("User-Agent", USER_AGENT);

        int responseCode = con.getResponseCode();
        System.out.println("\nSending 'GET' request to URL : " + url);
        System.out.println("Response Code : " + responseCode);
        this.responseCode = responseCode;
        if (responseCode == 200) {
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // print result
            this.responseMSG = response.toString();
        } else {
            this.responseMSG = null;
        }

    }

    // HTTP POST request
    private void sendPost(String url, String urlParameters) throws Exception {

        URL obj = new URL(url);
        // HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();

        // add request header
        con.setRequestMethod("POST");
        con.setRequestProperty("User-Agent", USER_AGENT);
        con.setRequestProperty("Content-Type", "application/json");
        con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

        // Send post request
        con.setDoOutput(true);
        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
        wr.writeBytes(urlParameters);
        wr.flush();
        wr.close();

        int responseCode = con.getResponseCode();
        System.out.println("\nSending 'POST' request to URL : " + url);
        System.out.println("Post parameters : " + urlParameters);
        System.out.println("Response Code : " + responseCode);
        this.responseCode = responseCode;

        if (responseCode == 200) {
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // print result
            this.responseMSG = response.toString();
        } else {
            this.responseMSG = null;
        }
    }

    @Test
    public void TestmsgEndpoint() throws Exception {
        sendGet("http://localhost:8080/rest/msg");

        assertEquals(HttpStatus.OK_200, this.responseCode);
        assertEquals("My message", this.responseMSG);

        sendGet("http://localhost:8080/rest/user/test?email=sander");
        assertEquals(HttpStatus.OK_200, this.responseCode);
        assertEquals("sander", this.responseMSG);

        sendGet("http://localhost:8080/rest/user/user?email=sander");
        assertEquals(HttpStatus.NOT_FOUND_404, this.responseCode);

        sendPost("http://localhost:8080/rest/user/add/", "{\"name\":\"sander\",\"email\":\"sander@revenberg.info\"}");
        String prediction = "{\"email\":\"sander@revenberg.info\",\"me\":\"/rest/user/\",\"name\":\"sander\",\"roles\":[\"default\"]}";
        String real = this.responseMSG.replaceAll("(.*)/rest/user/(.*)", "$1") + "/rest/user/\",\"name"
                + this.responseMSG.replaceAll(".*name(.*)", "$1");

        log.info(real);
        assertEquals(prediction, real);

        for (int i = 1; i < 5; i++) {
            sendPost("http://localhost:8080/rest/user/add/",
                    "{\"name\":\"sander " + Integer.toString(i) + "\",\"email\":\"sander@revenberg.info\"}");
        }
    }

    @Test
    public void TestUserEndpoint() throws IOException {
        String url = "http://localhost:8080/rest/msg";
        URLConnection connection = new URL(url).openConnection();
        try (InputStream response = connection.getInputStream(); Scanner scanner = new Scanner(response)) {
            String responseBody = scanner.nextLine();
            assertEquals("My message", responseBody);
        }
        // sendPost
    }
}