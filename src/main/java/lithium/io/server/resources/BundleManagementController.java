package lithium.io.server.resources;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.GenericEntity;
import javax.ws.rs.core.MediaType;

import lithium.io.server.model.Bundle;
import lithium.io.server.model.Song;

import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.core.Response;

import org.eclipse.jetty.http.HttpStatus;

@Path("bundle")
public class BundleManagementController {
    private static Logger log = Logger.getLogger(BundleManagementController.class.getName());

    @POST
    @Path("add")
    @Consumes(MediaType.TEXT_PLAIN)
    @Produces(MediaType.APPLICATION_JSON)
    public Response create(String name) throws SQLException {
    log.info(name);
    Bundle bundle = new Bundle();
        bundle.setName(name);
        bundle = bundle.add();
        return Response.status(200).entity(bundle).build();
    }

    @GET
    @Path("all")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getList() throws SQLException {

        List<Bundle> bundles = Bundle.getList();

        if (bundles.isEmpty()) {
            return Response.status(HttpStatus.NOT_FOUND_404).build();
        } else {
            GenericEntity<List<Bundle>> list = new GenericEntity<List<Bundle>>(bundles) {
            };
            return Response.status(HttpStatus.OK_200).entity(list).build();
        }
    }

    @GET
    @Path("search")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getList(@QueryParam("name") String name, @QueryParam("mnemonic") String mnemonic) throws SQLException {
        List<Bundle> bundles = null;
        if (name != "") {
            name = URLDecoder.decode(name);
            bundles = Bundle.getListByName(name);
        } else {
            if (mnemonic != "") {
                mnemonic = URLDecoder.decode(mnemonic);
                bundles = Bundle.getListByMnemonic(mnemonic);
            }
    
        }
        if (bundles.isEmpty()) {
            return Response.status(HttpStatus.NOT_FOUND_404).build();
        } else {
            GenericEntity<List<Bundle>> list = new GenericEntity<List<Bundle>>(bundles) {
            };
            return Response.status(HttpStatus.OK_200).entity(list).build();
        }
    }

    @GET
    @Path("{id}/songs")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getListOfSongs(@PathParam("id") int id) throws SQLException {

        List<Song> songs = Song.getAllSongOfBundle(id);

        if (songs.isEmpty()) {
            return Response.status(HttpStatus.NOT_FOUND_404).build();
        } else {
            GenericEntity<List<Song>> list = new GenericEntity<List<Song>>(songs) {
            };
            return Response.status(HttpStatus.OK_200).entity(list).build();
        }
    }

    @POST
    @Path("update")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateUser(Bundle bundle) throws SQLException {
        bundle.update();
        return Response.status(HttpStatus.OK_200).build();
    }

    @POST
    @Path("delete")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response delete(Bundle bundle) throws SQLException {
        bundle.delete();
        return Response.status(HttpStatus.OK_200).build();
    }

    @POST
    @Path("{id}/song/add")
    @Consumes(MediaType.TEXT_PLAIN)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addSongToBundle(@PathParam("id") int id, String name) throws SQLException {
        log.info(name);
        Song song = new Song();
        song.setBundleId(id);
        song.setName(URLDecoder.decode(name));
        song = song.add();
        return Response.status(HttpStatus.OK_200).entity(song).build();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getBundleById(@PathParam("id") int id) throws SQLException {
        if (id > 0) {
            Bundle bundle = Bundle.get(id);

            if (bundle != null) {
                return Response.status(HttpStatus.OK_200).entity(bundle).build();
            }
        }
        return Response.status(HttpStatus.NOT_FOUND_404).build();
    }
}