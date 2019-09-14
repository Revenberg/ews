package lithium.io.server.model;

import org.hibernate.validator.constraints.Email;

import lithium.io.server.storage.DBOUser;

import javax.validation.constraints.NotNull;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class User {
    
    @NotNull
    private int id;
    @NotNull
    private String me;
    @Email
    private String email;
    @NotNull
    private String name;    
    private List<String> next;

    public User() {          
     }

    public int getId() {
        return id;
    }

    public String getMe() {
        return me;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(final String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public List<String> getNext() {
        return next;
    }
    
    public static User get(int id) throws SQLException {
        return DBOUser.get(id);
    }

    public  void add() throws SQLException {
        DBOUser.add(this);
    }

    public static List<User> getList() throws SQLException {
        return DBOUser.getList();
    }

    public void update() throws SQLException {
        DBOUser.update(this);
    }

    public void delete() throws SQLException {
        DBOUser.delete(this.getId());
    }

    public void setMe(String s) {        
        this.me = "/rest/user/" + Integer.toString(this.id);
    }

    public void setId(int id) {
        this.id = id;
        setMe(null);
        setNext(null);
    }

    public void setNext(List<String> list) {        
        this.next = new ArrayList<String>();
        this.next.add("/rest/user/" + Integer.toString(this.id) + "/roles");        
    }
}