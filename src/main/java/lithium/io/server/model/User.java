package lithium.io.server.model;

import org.hibernate.validator.constraints.Email;
import javax.validation.constraints.NotNull;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;
import java.util.logging.Logger;

public class User {
    private static Logger log = Logger.getLogger(User.class.getName());

    static private List<User> list = new ArrayList<User>();

    @NotNull
    private int id;
    @NotNull
    private String me;
    @Email
    private String email;
    @NotNull
    private String name;
    @NotNull
    private List<String> roles;

    public User() {        
        setId();
        setMe("");
        addRole("default");
    }

    public User(String name, String email) {
        this();                
        setEmail(email);
        setName(name);
        
    }

    public void setId() {
        this.id = list.size() + 1;
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

    public List<String> getRoles() {
        return roles;
    }

    public void addRole(String role) {
        if (this.roles == null) {
            this.roles = new ArrayList<String>();
        }
        this.roles.add(role);
    }

    public void setRoles(final List<String> roles) {
        this.roles = roles;
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;
        final User user = (User) o;
        return Objects.equals(email, user.email) && Objects.equals(name, user.name)
                && Objects.equals(roles, user.roles);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, email, name, roles);
    }

    public static User getUserByEmail(String email) {
        Iterator<User> iterator = list.iterator();
        User user;
        User rc = null;
        while (iterator.hasNext() && rc == null) {
            user = iterator.next();
            if (user.email.equals(email)) {
                rc = user;
            }
        }
        return rc;
    }

    public static User getUserById(int id) {
        Iterator<User> iterator = list.iterator();
        User user;
        User rc = null;
        while (iterator.hasNext() && rc == null) {
            user = iterator.next();
            if (user.id == id) {
                rc = user;
            }
        }
        return rc;
    }

    public static void addUser(User user) {
        list.add(user);
    }

    public static List<User> getAllUsers() {
        return User.list;
    }

    public static boolean updateUser(int id, User user) {
        User u = User.getUserById(id);
        if (u == null) {
            return false;
        }
        list.remove(u);
        list.add(user);
        return true;
    }

    public static boolean deleteUser(int id) {
        User u = User.getUserById(id);
        if (u == null) {
            return false;
        }
        list.remove(u);
        return true;
    }

	public void setMe(String s) {
        this.me = "/rest/user/" + Integer.toString(this.id);
	}

}