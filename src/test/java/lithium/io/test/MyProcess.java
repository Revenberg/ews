package lithium.io.test;

import java.io.File;
import java.net.HttpURLConnection;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.ws.rs.core.MediaType;

import com.google.gson.Gson;

import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.InputStreamReader;

import org.eclipse.jetty.http.HttpStatus;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;

import lithium.io.server.model.Song;
import lithium.io.server.model.Vers;
import lithium.io.schedule.Tools;
import lithium.io.server.model.Bundle;

public class MyProcess {
    private static Logger log = Logger.getLogger(MyProcess.class.getName());
    private final String USER_AGENT = "Mozilla/5.0";

    // List<String> bundles = new ArrayList<>();
    List<String> songes = new ArrayList<>();
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
    private void sendPost(String url, String urlParameters, String mediaType) throws Exception {

        URL obj = new URL(url);
        // HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();

        // add request header
        con.setRequestMethod("POST");
        con.setRequestProperty("User-Agent", USER_AGENT);
        con.setRequestProperty("Content-Type", mediaType);
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

    // sendGet("http://localhost:8080/rest/user/user?email=sander");
    // assertEquals(HttpStatus.NOT_FOUND_404, this.responseCode);

    // sendPost("http://localhost:8080/rest/user/add/",
    // "{\"name\":\"sander\",\"email\":\"sander@revenberg.info\"}");

    public Bundle bundle(String name) throws Exception {
        // if (!bundles.contains(name)) {
        // bundles.add(name);
        // }
        // sendGet("http://localhost:8080/rest/bundle/search?name=" +
        // URLEncoder.encode(name));
        // if (HttpStatus.NOT_FOUND_404 == this.responseCode) {
        sendPost("http://localhost:8080/rest/bundle/add/", name, MediaType.TEXT_PLAIN);
        // "{\"name\":\"" + name + "\",\"bundleid\":0}");
        // }

        Bundle bundle = new Gson().fromJson(this.responseMSG, Bundle.class);
        return bundle;
    }

    private Song song(int bundleid, String name) throws Exception {
        sendPost("http://localhost:8080/rest/bundle/" + Integer.toString(bundleid) + "/song/add",
                URLEncoder.encode(name), MediaType.TEXT_PLAIN);
        // "{\"name\":\""+ URLEncoder.encode(name) + "\",\"id\":0}");
        Song song = new Gson().fromJson(this.responseMSG, Song.class);
        return song;
    }

    private void uploadPost(String url, String filename, String fileloc) throws Exception {
        // File inFile = new File(filename);
        MultipartUtility multipart = new MultipartUtility(url, "UTF-8");
        multipart.addFilePart(filename, new File(fileloc));
        List<String> response = multipart.finish();
        for (String line : response) {
            log.info("Upload Files Response:::" + line);
            // get your server response here.
        }
    }

    private void callVers(int songid, Vers vers) throws Exception {
        sendPost("http://localhost:8080/rest/song/" + Integer.toString(songid) + "/vers/add",
                "{\"name\":\"" + URLEncoder.encode(vers.getName()) + "\",\"id\":0,\"location\":\""
                        + URLEncoder.encode(vers.getLocation()) + "\"}",
                MediaType.APPLICATION_JSON);
        vers = new Gson().fromJson(this.responseMSG, Vers.class);
        log.info(vers.getName());
    }

    public MyProcess(String location) throws Exception {
        final File folder = new File(location);

        List<String> list = new ArrayList<>();

        search(".*", folder, list, "");

        int bundleid;
        int songid;
        Vers vers;
        int counter;
        for (String e : list) {
            if (e.contains(".ppt")) {
                bundleid = 0;
                songid = 0;
                counter = 0;
                String[] s = e.split("/");
                log.info(location + "/" + e);
                Tools.createFolderIfNotExists(Tools.tempDir + "/unzip");
                List<String> filelist = Tools.unzip(location + "/" + e, Tools.tempDir + "/unzip");
                for (String filename : filelist) {
                    if (filename.endsWith(".png")) {
                        System.out.println(filename);

                        if (bundleid == 0) {
                            if (s.length < 3) {
                                bundleid = bundle(s[0]).getId();
                                songid = song(bundleid, s[1].replace(".ppt", "")).getId();
                            } else {
                                bundleid = bundle(s[0] + " - " + s[1]).getId();
                                songid = song(bundleid, s[2].replace(".ppt", "")).getId();
                            }
                        }
                        counter++;
                        vers = new Vers();
                        vers.setName("Vers " + Integer.toString(counter));
                        vers.setLocation("");
                        vers.setVers(counter);
                        callVers(songid, vers);
                        log.info(Integer.toString(songid));
                        uploadPost("http://localhost:8080/rest/vers/add" + Integer.toString(songid),
                                "Vers " + Integer.toString(counter), filename);

                    }
                }
            }
        }
    }

    public static void main(String[] args) throws Exception {
        MyProcess myProcess = new MyProcess("D:/pptx");
    }

}
