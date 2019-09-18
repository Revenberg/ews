package lithium.io.server.model;

import lithium.io.server.storage.DBOBundle;

import javax.validation.constraints.NotNull;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Bundle {

    @NotNull
    private int id;
    private int bundleId;
    @NotNull
    private String name;
    @NotNull
    private String me;
    
    private String mnemonic;

    private List<String> next;

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
        return this.me;
    }

    public String getName() {
        return this.name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public String getMnemonic() {
        if (this.mnemonic == null) {
            this.setMnemonic("");
        }
        return this.mnemonic;
    }

    public void setMnemonic(final String mnemonic) {
        this.mnemonic = mnemonic;
    }

    public List<String> getNext() {
        return next;
    }

    public void setNext(List<String> list) {        
        this.next = new ArrayList<String>();
        this.next.add("/rest/bundle/" + Integer.toString(this.id) + "/songs");        
        this.next.add("/rest/bundle/" + Integer.toString(this.id) + "/song/add");
    }

    public Bundle add() throws SQLException {
        List<Bundle> list = getListByName(this.getName());
        if (list.size() == 0) {
            return DBOBundle.add(this);
        } else {
            return list.get(0);
        }
    }

    public static List<Bundle> getList() throws SQLException {
        return DBOBundle.getList();
    }

    public static List<Bundle> getListByName(String name) throws SQLException {
        return DBOBundle.getListByName(name);
    }

    public static List<Bundle> getListByMnemonic(String mnemonic) throws SQLException {
        return DBOBundle.getListByMnemonic(mnemonic);
    }

    public void setMe(String s) {
        this.me = "/rest/bundle/" + Integer.toString(this.id);
    }

    public void setId(int id) {
        this.id = id;
        setMe(null);
        setNext(null);
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