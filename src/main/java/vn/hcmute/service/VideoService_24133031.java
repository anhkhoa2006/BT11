package vn.hcmute.service;

import java.util.List;
import vn.hcmute.dao.IVideoDao_24133031;
import vn.hcmute.dao.VideoDao_24133031;
import vn.hcmute.entity.Video_24133031;

public class VideoService_24133031 implements IVideoService_24133031 {
    private final IVideoDao_24133031 videoDao = new VideoDao_24133031();

    @Override
    public Video_24133031 findById(String videoId) {
        return videoDao.findById(videoId);
    }

    @Override
    public List<Video_24133031> findAll() {
        return videoDao.findAll();
    }

    @Override
    public List<Video_24133031> findAll(int page, int pageSize) {
        return videoDao.findAll(page, pageSize);
    }

    @Override
    public long count() {
        return videoDao.count();
    }

    @Override
    public List<Video_24133031> findByCategory(int categoryId, int page, int pageSize) {
        return videoDao.findByCategory(categoryId, page, pageSize);
    }

    @Override
    public long countByCategory(int categoryId) {
        return videoDao.countByCategory(categoryId);
    }

    @Override
    public long countLikes(String videoId) {
        return videoDao.countLikes(videoId);
    }

    @Override
    public long countShares(String videoId) {
        return videoDao.countShares(videoId);
    }

    @Override
    public void insert(Video_24133031 video) {
        videoDao.insert(video);
    }

    @Override
    public void update(Video_24133031 video) {
        videoDao.update(video);
    }

    @Override
    public void delete(String videoId) throws Exception {
        videoDao.delete(videoId);
    }

    @Override
    public void increaseViews(String videoId) {
        videoDao.increaseViews(videoId);
    }
}
