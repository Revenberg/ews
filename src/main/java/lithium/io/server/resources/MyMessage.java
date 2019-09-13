package lithium.io.server.resources;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.eclipse.jetty.http.HttpStatus;
import javax.ws.rs.core.Response;

@Path("msg")
public class MyMessage {

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String getMessage() {
        return "My message\n";
    }

    @GET
    @Path("{msg}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response  getMessage1(@PathParam("msg") String msg) {
             return Response.status(HttpStatus.OK_200).entity(msg).build();
        }
    
}