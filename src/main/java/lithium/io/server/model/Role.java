package lithium.io.server.model;

import lithium.io.server.storage.DBORole;

import javax.validation.constraints.NotNull;

import java.sql.SQLException;
import java.util.List;

public class Role {   
    @NotNull
    private int id;
    @NotNull
    private int userid;
    @NotNull
    private String me;
    @NotNull
    private String name;
    @NotNull
    private Boolean active;

    public Role() {
    }

    public int getId() {
        return id;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getMe() {
        return me;
    }

    public String getName() {
        return name;
    }

    public Boolean getActive() {
        return active;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public void setActive(final Boolean active) {
        this.active = active;
    }

    public void add() throws SQLException {
        DBORole.add(this);
    }

    public static List<Role> getlistByUserId(int userid) throws SQLException {
        return DBORole.getList(userid);
    }

    public void activeRole(Role role) throws SQLException {
        DBORole.active(role);
    }

    public void setMe(String s) {
        this.me = "/rest/role/" + Integer.toString(this.id);
    }

    public void setId(int id) {
        this.id = id;
    }

}