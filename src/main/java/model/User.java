

package model;

import java.sql.Date;
//
public class User {
    private int id;
    private String username;
    private String password;
    private String role;
    private Date createAt;

    public User() {
    }

    public User(int id, String username, String password, String role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public User(int id, String username, String password, String role, Date createAt) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.role = role;
        this.createAt = createAt;
    }
    
    
    /*
    Display username format: us [id]
    */
    public String getDisplayName(){
        return String.format("%s [%d]", this.username, this.id);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }
    
    
}