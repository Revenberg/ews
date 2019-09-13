package lithium.io.server.resources;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.GenericEntity;
import javax.ws.rs.core.MediaType;
import lithium.io.server.model.User;

import java.util.List;
import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.core.Response;

import org.eclipse.jetty.http.HttpStatus;

@Path("user")
public class UserManagementController {
    private static Logger log = Logger.getLogger(UserManagementController.class.getName());

    @GET
    @Path("test")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getMessage(@QueryParam("email") String msg) {
        return Response.status(HttpStatus.OK_200).entity(msg).build();
    }

    @POST
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response createUser(User user) {        
        User.addUser(user);
        user.setMe("");
        return Response.status(200).entity(user).build();
    }

    @GET
    @Path("all")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllUsers() {

        List<User> users = User.getAllUsers();        

        if (users.isEmpty()) {
            return Response.status(HttpStatus.NOT_FOUND_404).build();
        } else {
            GenericEntity<List<User>> list = new GenericEntity<List<User>>(users){};
            return Response.status(HttpStatus.OK_200).entity(list).build();
        }
    }

    @POST
    @Path("update/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateUser(@PathParam("id") int id, @QueryParam("name") String name,
            @QueryParam("email") String email) {
        User user = new User(name, email);
        if (User.updateUser(id, user)) {
            return Response.status(HttpStatus.OK_200).build();
        } else {
            return Response.status(HttpStatus.NOT_FOUND_404).build();
        }
    }

    @POST
    @Path("delete/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response deleteUserByEmail(@PathParam("id") int id) {
        if (User.deleteUser(id)) {
            return Response.status(HttpStatus.OK_200).build();
        }
        return Response.status(HttpStatus.NOT_FOUND_404).build();
    }
    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getUserById(@PathParam("id") int id) {
        if (id > 0) {
            User user = User.getUserById(id);
            if (user != null) {
                return Response.status(HttpStatus.OK_200).entity(user).build();
            }
        }
        return Response.status(HttpStatus.NOT_FOUND_404).build();
    }
}