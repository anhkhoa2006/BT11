package vn.hcmute.service;

import java.util.List;
import vn.hcmute.entity.User_24133031;

public interface IUserService_24133031 {
    User_24133031 findById(String username);
    User_24133031 findByEmail(String email);
    List<User_24133031> findAll();
    void insert(User_24133031 user);
    void update(User_24133031 user);
    void delete(String username) throws Exception;
    User_24133031 login(String username, String password);
}
