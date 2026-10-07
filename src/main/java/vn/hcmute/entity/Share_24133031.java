package vn.hcmute.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Shares")
public class Share_24133031 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ShareId")
    private int shareId;

    @Column(name = "Emails", length = 50)
    private String emails;

    @Temporal(TemporalType.DATE)
    @Column(name = "SharedDate")
    private Date sharedDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Username", nullable = false)
    private User_24133031 user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "VideoId", nullable = false)
    private Video_24133031 video;

    public Share_24133031() {
    }

    public Share_24133031(String emails, Date sharedDate, User_24133031 user, Video_24133031 video) {
        this.emails = emails;
        this.sharedDate = sharedDate;
        this.user = user;
        this.video = video;
    }

    public int getShareId() {
        return shareId;
    }

    public void setShareId(int shareId) {
        this.shareId = shareId;
    }

    public String getEmails() {
        return emails;
    }

    public void setEmails(String emails) {
        this.emails = emails;
    }

    public Date getSharedDate() {
        return sharedDate;
    }

    public void setSharedDate(Date sharedDate) {
        this.sharedDate = sharedDate;
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
