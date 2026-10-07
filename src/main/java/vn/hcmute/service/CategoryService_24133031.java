package vn.hcmute.service;

import java.util.List;
import vn.hcmute.dao.CategoryDao_24133031;
import vn.hcmute.dao.ICategoryDao_24133031;
import vn.hcmute.entity.Category_24133031;

public class CategoryService_24133031 implements ICategoryService_24133031 {
    private final ICategoryDao_24133031 categoryDao = new CategoryDao_24133031();

    @Override
    public Category_24133031 findById(int categoryId) {
        return categoryDao.findById(categoryId);
    }

    @Override
    public List<Category_24133031> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public List<Category_24133031> findAllActive() {
        return categoryDao.findAllActive();
    }

    @Override
    public long countVideosByCategory(int categoryId) {
        return categoryDao.countVideosByCategory(categoryId);
    }

    @Override
    public void insert(Category_24133031 category) {
        categoryDao.insert(category);
    }

    @Override
    public void update(Category_24133031 category) {
        categoryDao.update(category);
    }

    @Override
    public void delete(int categoryId) throws Exception {
        categoryDao.delete(categoryId);
    }
}
