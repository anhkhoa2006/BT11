package vn.hcmute.service;

import java.util.List;
import vn.hcmute.dao.IProductDao_24133031;
import vn.hcmute.dao.ProductDao_24133031;
import vn.hcmute.entity.Product_24133031;

public class ProductService_24133031 implements IProductService_24133031 {
    private final IProductDao_24133031 productDao = new ProductDao_24133031();

    @Override
    public Product_24133031 findById(int productId) {
        return productDao.findById(productId);
    }

    @Override
    public List<Product_24133031> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product_24133031> findAllActive() {
        return productDao.findAllActive();
    }

    @Override
    public List<Product_24133031> findByCategory(int categoryId, int page, int pageSize) {
        return productDao.findByCategory(categoryId, page, pageSize);
    }

    @Override
    public List<Product_24133031> findAllPaging(int page, int pageSize) {
        return productDao.findAllPaging(page, pageSize);
    }

    @Override
    public long countByCategory(int categoryId) {
        return productDao.countByCategory(categoryId);
    }

    @Override
    public long countAll() {
        return productDao.countAll();
    }

    @Override
    public void insert(Product_24133031 product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product_24133031 product) {
        productDao.update(product);
    }

    @Override
    public void delete(int productId) throws Exception {
        productDao.delete(productId);
    }

    @Override
    public void updateStock(int productId, int quantityChange) {
        productDao.updateStock(productId, quantityChange);
    }
}
