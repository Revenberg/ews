package lithium.io.server.resources;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.GenericEntity;
import javax.ws.rs.core.MediaType;

import lithium.io.schedule.Tools;
import lithium.io.server.model.Vers;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.core.Response;

import org.eclipse.jetty.http.HttpStatus;

//import com.sun.jersey.core.header.FormDataContentDisposition;
//import com.sun.jersey.multipart.FormDataParam;  

@Path("vers")
public class VersManagementController {    

/*    @POST
    @Path("{id}/upload")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
	public Response uploadFile(
			@FormDataParam("file") InputStream uploadedInputStream,
			@FormDataParam("file") FormDataContentDisposition fileDetail) {
		// check if all form parameters are provided
		if (uploadedInputStream == null || fileDetail == null)
			return Response.status(400).entity("Invalid form data").build();
		// create our destination folder, if it not exists
		try {
			Tools.createFolderIfNotExists(Tools.tempDir + "/image");
		} catch (SecurityException se) {
			return Response.status(500)
					.entity("Can not create destination folder on server")
					.build();
		}
		String uploadedFileLocation = Tools.tempDir + "/image" + fileDetail.getFileName();
		try {
			Tools.saveToFile(uploadedInputStream, uploadedFileLocation);
		} catch (IOException e) {
			return Response.status(500).entity("Can not save file").build();
		}
		return Response.status(200)
				.entity("File saved to " + uploadedFileLocation).build();
    }
*/
    @GET
    @Path("{id}/verses")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getListBySongId(@PathParam("id") int id) throws SQLException {

        List<Vers> verses = Vers.getListBySongId(id);

        if (verses.isEmpty()) {
            return Response.status(HttpStatus.NOT_FOUND_404).build();
        } else {
            GenericEntity<List<Vers>> list = new GenericEntity<List<Vers>>(verses) {
            };
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