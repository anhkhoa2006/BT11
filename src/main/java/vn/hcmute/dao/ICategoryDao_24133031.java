package vn.hcmute.dao;

import java.util.List;
import vn.hcmute.entity.Category_24133031;

public interface ICategoryDao_24133031 {
    Category_24133031 findById(int categoryId);
    List<Category_24133031> findAll();
    List<Category_24133031> findAllActive();
    long countVideosByCategory(int categoryId);
    void insert(Category_24133031 category);
    void update(Category_24133031 category);
    void delete(int categoryId) throws Exception;
}
