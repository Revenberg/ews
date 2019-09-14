package lithium.io.server.resources;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.GenericEntity;
import javax.ws.rs.core.MediaType;

import lithium.io.server.model.Role;
import lithium.io.server.model.User;

import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.core.Response;

import org.eclipse.jetty.http.HttpStatus;

@Path("user")
public class UserManagementController {
    private static Logger log = Logger.getLogger(UserManagementController.class.getName());

    @POST
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response createUser(User user) throws SQLException {
        user.add();
        return Response.status(200).entity(user).build();
    }

    @GET
    @Path("all")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllUsers() throws SQLException {

        List<User> users = User.getList();

        if (users.isEmpty()) {
            return Response.status(HttpStatus.NOT_FOUND_404).build();
        } else {
            GenericEntity<List<User>> list = new GenericEntity<List<User>>(users) {
            };
            return Response.status(HttpStatus.OK_200).entity(list).build();
        }
    }

    @POST
    @Path("delete")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response deleteUserByEmail(User user) throws SQLException {
        user.delete();
        return Response.status(HttpStatus.OK_200).build();
    }

    @GET
    @Path("{id}/roles")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getUserRolesByUserId(@PathParam("id") int id) throws SQLException {
        log.info("getUserRolesById");
        List<Role> roles = Role.getlistByUserId(id);

        if (roles.isEmpty()) {
            return Response.status(HttpStatus.NOT_FOUND_404).build();
        } else {
            GenericEntity<List<Role>> list = new GenericEntity<List<Role>>(roles) {
            };
            return Response.status(HttpStatus.OK_200).entity(list).build();
        }
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getUserById(@PathParam("id") int id) throws SQLException {
        if (id > 0) {
            User user = User.get(id);

            if (user != null) {
                return Response.status(HttpStatus.OK_200).entity(user).build();
            }
        }
        return Response.status(HttpStatus.NOT_FOUND_404).build();
    }
}