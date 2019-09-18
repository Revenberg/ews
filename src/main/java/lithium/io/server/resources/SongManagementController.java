package lithium.io.server.resources;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.GenericEntity;
import javax.ws.rs.core.MediaType;

import lithium.io.server.model.Song;
import lithium.io.server.model.Vers;

import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.core.Response;

import org.eclipse.jetty.http.HttpStatus;

@Path("song")
public class SongManagementController {
    private static Logger log = Logger.getLogger(SongManagementController.class.getName());

    /*
    @POST
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response create(Song song) throws SQLException {
        song.add();
        return Response.status(200).entity(song).build();
    }
*/
    @GET
    @Path("all")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getList() throws SQLException {

        List<Song> songs = Song.getList();        

        if (songs.isEmpty()) {
            return Response.status(HttpStatus.NOT_FOUND_404).build();
        } else {
            GenericEntity<List<Song>> list = new GenericEntity<List<Song>>(songs){};
            return Response.status(HttpStatus.OK_200).entity(list).build();
        }
    }
        
    @POST
    @Path("update")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response update(Song song) throws SQLException {
        song.update();     
        return Response.status(HttpStatus.OK_200).build();   
    }

    @POST
    @Path("delete")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response delete(Song song) throws SQLException {
        song.delete();
            return Response.status(HttpStatus.OK_200).build();        
    }

    @GET
    @Path("{id}/verses")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getListOfVerses(@PathParam("id") int id) throws SQLException {

        List<Vers> verses = Vers.getListBySongId(id);

        if (verses.isEmpty()) {
            return Response.status(HttpStatus.NOT_FOUND_404).build();
        } else {
            GenericEntity<List<Vers>> list = new GenericEntity<List<Vers>>(verses) {};
            return Response.status(HttpStatus.OK_200).entity(list).build();
        }
    }

    @POST
    @Path("{id}/vers/add")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addVersToSong(@PathParam("id") int id, Vers vers) throws SQLException {
//        Vers vers = new Vers();
        vers.setSongId(id);
  //      log.info(name);
  //      log.info(location);
  //      vers.setName(URLDecoder.decode(name));
  //      vers.setLocation(URLDecoder.decode(location));
        vers = vers.add();
        return Response.status(HttpStatus.OK_200).entity(vers).build();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getSongById(@PathParam("id") int id) throws SQLException {
        if (id > 0) {
            Song song = Song.get(id);

            if (song != null) {
                return Response.status(HttpStatus.OK_200).entity(song).build();
            }
        }
        return Response.status(HttpStatus.NOT_FOUND_404).build();
    }
}