package vn.hcmute.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "Users")
@NamedQueries({
    @NamedQuery(name = "User_24133031.findAll", query = "SELECT u FROM User_24133031 u")
})
public class User_24133031 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "Username", length = 50, nullable = false)
    private String username;

    @Column(name = "Password", length = 50, nullable = false)
    private String password;

    @Column(name = "Phone", length = 15)
    private String phone;

    @Column(name = "Fullname", length = 50)
    private String fullname;

    @Column(name = "Email", length = 150)
    private String email;

    @Column(name = "Admin", nullable = false)
    private boolean admin;

    @Column(name = "Active", nullable = false)
    private boolean active;

    @Column(name = "Images", length = 500)
    private String images;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Share_24133031> shares;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Favorite_24133031> favorites;

    public User_24133031() {
    }

    public User_24133031(String username, String password, String phone, String fullname, String email, boolean admin, boolean active, String images) {
        this.username = username;
        this.password = password;
        this.phone = phone;
        this.fullname = fullname;
        this.email = email;
        this.admin = admin;
        this.active = active;
        this.images = images;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public List<Share_24133031> getShares() {
        return shares;
    }

    public void setShares(List<Share_24133031> shares) {
        this.shares = shares;
    }

    public List<Favorite_24133031> getFavorites() {
        return favorites;
    }

    public void setFavorites(List<Favorite_24133031> favorites) {
        this.favorites = favorites;
    }
}
