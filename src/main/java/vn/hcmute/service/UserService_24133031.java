package vn.hcmute.service;

import java.util.List;
import vn.hcmute.dao.IUserDao_24133031;
import vn.hcmute.dao.UserDao_24133031;
import vn.hcmute.entity.User_24133031;

public class UserService_24133031 implements IUserService_24133031 {
    private final IUserDao_24133031 userDao = new UserDao_24133031();

    @Override
    public User_24133031 findById(String username) {
        return userDao.findById(username);
    }

    @Override
    public User_24133031 findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public List<User_24133031> findAll() {
        return userDao.findAll();
    }

    @Override
    public void insert(User_24133031 user) {
        userDao.insert(user);
    }

    @Override
    public void update(User_24133031 user) {
        userDao.update(user);
    }

    @Override
    public void delete(String username) throws Exception {
        userDao.delete(username);
    }

    @Override
    public User_24133031 login(String username, String password) {
        User_24133031 user = userDao.findById(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}
