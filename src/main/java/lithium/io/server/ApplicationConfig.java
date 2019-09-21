package lithium.io.server;

import javax.ws.rs.ApplicationPath;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.media.multipart.MultiPartFeature;
@ApplicationPath("service") // set the path to REST web services
public class ApplicationConfig extends ResourceConfig {
   public ApplicationConfig() {
     packages("lithium.io.server.resources").register(MultiPartFeature.class);
   }
}