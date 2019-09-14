package lithium.io.server.model;

import lithium.io.server.storage.DBOBundle;

import javax.validation.constraints.NotNull;

import java.sql.SQLException;
import java.util.List;

public class Bundle {    

    @NotNull
    private int id;
    @NotNull
    private int bundleId;
    @NotNull
    private String name;
    @NotNull
    private String me;
    @NotNull
    
    public Bundle() {
    }

    public int getId() {
        return id;
    }

    public int getBundleId() {
        return bundleId;
    }

    public void setBundleId(int bundleId) {
        this.bundleId = bundleId;
    }

    public String getMe() {
        return me;
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public void add() throws SQLException {
        DBOBundle.add(this);
    }

    public static List<Bundle> getList() throws SQLException {
        return DBOBundle.getList();
    }

    public void setMe(String s) {
        this.me = "/rest/role/" + Integer.toString(this.id);
    }

    public void setId(int id) {
        this.id = id;
    }

    public static Bundle get(int id) throws SQLException {
        return DBOBundle.get(id);
    }

	public void delete() throws SQLException {
        DBOBundle.delete(this.getId());
	}

	public void update() throws SQLException {
        DBOBundle.update(this);
	}

}