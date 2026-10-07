package vn.hcmute.service;

import java.util.List;
import vn.hcmute.entity.Product_24133031;

public interface IProductService_24133031 {
    Product_24133031 findById(int productId);
    List<Product_24133031> findAll();
    List<Product_24133031> findAllActive();
    List<Product_24133031> findByCategory(int categoryId, int page, int pageSize);
    List<Product_24133031> findAllPaging(int page, int pageSize);
    long countByCategory(int categoryId);
    long countAll();
    void insert(Product_24133031 product);
    void update(Product_24133031 product);
    void delete(int productId) throws Exception;
    void updateStock(int productId, int quantityChange);
}
