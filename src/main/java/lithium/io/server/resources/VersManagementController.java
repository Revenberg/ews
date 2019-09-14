package lithium.io.server.resources;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.GenericEntity;
import javax.ws.rs.core.MediaType;

import lithium.io.server.model.Vers;

import java.sql.SQLException;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.core.Response;

import org.eclipse.jetty.http.HttpStatus;

@Path("vers")
public class VersManagementController {

    @POST
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response create(Vers vers) throws SQLException {
        vers.add();
        return Response.status(200).entity(vers).build();
    }
     
    @GET
    @Path("{id}/verses")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getListBySongId(@PathParam("id") int id) throws SQLException {

        List<Vers> verses = Vers.getListBySongId(id);        

        if (verses.isEmpty()) {
            return Response.status(HttpStatus.NOT_FOUND_404).build();
        } else {
            GenericEntity<List<Vers>> list = new GenericEntity<List<Vers>>(verses){};
            return Response.status(HttpStatus.OK_200).entity(list).build();
        }
    }
    @POST
    @Path("update")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response update(Vers vers) throws SQLException {
        vers.update();     
        return Response.status(HttpStatus.OK_200).build();   
    }

    @POST
    @Path("delete")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response delete(Vers vers) throws SQLException {
        vers.delete();
            return Response.status(HttpStatus.OK_200).build();        
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getSongById(@PathParam("id") int id) throws SQLException {
        if (id > 0) {
            Vers vers = Vers.get(id);

            if (vers != null) {
                return Response.status(HttpStatus.OK_200).entity(vers).build();
            }
        }
        return Response.status(HttpStatus.NOT_FOUND_404).build();
    }
}