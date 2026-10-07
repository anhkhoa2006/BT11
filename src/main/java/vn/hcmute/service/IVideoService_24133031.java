package vn.hcmute.service;

import java.util.List;
import vn.hcmute.entity.Video_24133031;

public interface IVideoService_24133031 {
    Video_24133031 findById(String videoId);
    List<Video_24133031> findAll();
    List<Video_24133031> findAll(int page, int pageSize);
    long count();
    List<Video_24133031> findByCategory(int categoryId, int page, int pageSize);
    long countByCategory(int categoryId);
    long countLikes(String videoId);
    long countShares(String videoId);
    void insert(Video_24133031 video);
    void update(Video_24133031 video);
    void delete(String videoId) throws Exception;
    void increaseViews(String videoId);
}
