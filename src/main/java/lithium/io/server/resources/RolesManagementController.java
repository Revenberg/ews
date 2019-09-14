package lithium.io.server.resources;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import lithium.io.server.model.Role;

import java.sql.SQLException;
import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.core.Response;

import org.eclipse.jetty.http.HttpStatus;

@Path("role")
public class RolesManagementController {
    
    @POST
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response createrole(Role role) throws SQLException {
        Role.add(role);
        role.setMe("");
        return Response.status(200).entity(role).build();
    }
/*
    @GET
    @Path("user/{userid}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllroles(@PathParam("userid") int userid) throws SQLException {

        List<Role> roles = Role.getAllRoles(userid);        

        if (roles.isEmpty()) {
            return Response.status(HttpStatus.NOT_FOUND_404).build();
        } else {
            GenericEntity<List<Role>> list = new GenericEntity<List<Role>>(roles){};
            return Response.status(HttpStatus.OK_200).entity(list).build();
        }
    }
/*
    @POST
    @Path("update/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updaterole(@PathParam("id") int id, @QueryParam("name") String name,
            @QueryParam("email") String email) throws SQLException {
        Role role = new role(name, email);
        role.updateRole(role);     
        return Response.status(HttpStatus.OK_200).build();   
    }

    @POST
    @Path("delete/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response deleteroleByEmail(@PathParam("id") int id) throws SQLException {
        role.deleterole(id);
            return Response.status(HttpStatus.OK_200).build();        
    }
    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getroleById(@PathParam("id") int id) throws SQLException {
        if (id > 0) {
            role role = role.getroleById(id);
            if (role != null) {
                return Response.status(HttpStatus.OK_200).entity(role).build();
            }
        }
        return Response.status(HttpStatus.NOT_FOUND_404).build();
    }
    */
    @GET
    @Path("activate")
    @Produces(MediaType.APPLICATION_JSON)
    public Response activateRole(Role role) throws SQLException {
        role.activeRole(role);
        return Response.status(HttpStatus.OK_200).build();
    }
}