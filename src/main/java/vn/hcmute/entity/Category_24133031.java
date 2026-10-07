package vn.hcmute.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "Category")
@NamedQueries({
    @NamedQuery(name = "Category_24133031.findAll", query = "SELECT c FROM Category_24133031 c")
})
public class Category_24133031 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CategoryId")
    private int categoryId;

    @Column(name = "Categoryname", length = 100, nullable = false)
    private String categoryname;

    @Column(name = "Categorycode", length = 100)
    private String categorycode;

    @Column(name = "Images", length = 500)
    private String images;

    @Column(name = "Status", nullable = false)
    private boolean status;

    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Video_24133031> videos;

    // Phục vụ câu 4 & 5
    @Transient
    private long videoCount;

    public Category_24133031() {
    }

    public Category_24133031(int categoryId, String categoryname, String categorycode, String images, boolean status) {
        this.categoryId = categoryId;
        this.categoryname = categoryname;
        this.categorycode = categorycode;
        this.images = images;
        this.status = status;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getCategorycode() {
        return categorycode;
    }

    public void setCategorycode(String categorycode) {
        this.categorycode = categorycode;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public List<Video_24133031> getVideos() {
        return videos;
    }

    public void setVideos(List<Video_24133031> videos) {
        this.videos = videos;
    }

    public long getVideoCount() {
        return videoCount;
    }

    public void setVideoCount(long videoCount) {
        this.videoCount = videoCount;
    }
}
