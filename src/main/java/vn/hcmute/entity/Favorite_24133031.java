package vn.hcmute.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Favorites")
public class Favorite_24133031 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "FavoriteId")
    private int favoriteId;

    @Temporal(TemporalType.DATE)
    @Column(name = "LikedDate")
    private Date likedDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Username", nullable = false)
    private User_24133031 user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "VideoId", nullable = false)
    private Video_24133031 video;

    public Favorite_24133031() {
    }

    public Favorite_24133031(Date likedDate, User_24133031 user, Video_24133031 video) {
        this.likedDate = likedDate;
        this.user = user;
        this.video = video;
    }

    public int getFavoriteId() {
        return favoriteId;
    }

    public void setFavoriteId(int favoriteId) {
        this.favoriteId = favoriteId;
    }

    public Date getLikedDate() {
        return likedDate;
    }

    public void setLikedDate(Date likedDate) {
        this.likedDate = likedDate;
    }

    public User_24133031 getUser() {
        return user;
    }

    public void setUser(User_24133031 user) {
        this.user = user;
    }

    public Video_24133031 getVideo() {
        return video;
    }

    public void setVideo(Video_24133031 video) {
        this.video = video;
    }
}
