package vn.hcmute.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "Videos")
@NamedQueries({
    @NamedQuery(name = "Video_24133031.findAll", query = "SELECT v FROM Video_24133031 v")
})
public class Video_24133031 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "VideoId", length = 50, nullable = false)
    private String videoId;

    @Column(name = "Title", length = 200, nullable = false)
    private String title;

    @Column(name = "Poster", length = 500)
    private String poster;

    @Column(name = "Views")
    private int views;

    @Column(name = "Description", length = 500)
    private String description;

    @Column(name = "Active", nullable = false)
    private boolean active;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CategoryId", nullable = false)
    private Category_24133031 category;

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Share_24133031> shares;

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Favorite_24133031> favorites;

    @Transient
    private long likeCount;

    @Transient
    private long shareCount;

    public Video_24133031() {
    }

    public Video_24133031(String videoId, String title, String poster, int views, String description, boolean active, Category_24133031 category) {
        this.videoId = videoId;
        this.title = title;
        this.poster = poster;
        this.views = views;
        this.description = description;
        this.active = active;
        this.category = category;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Category_24133031 getCategory() {
        return category;
    }

    public void setCategory(Category_24133031 category) {
        this.category = category;
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

    public long getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(long likeCount) {
        this.likeCount = likeCount;
    }

    public long getShareCount() {
        return shareCount;
    }

    public void setShareCount(long shareCount) {
        this.shareCount = shareCount;
    }
}
