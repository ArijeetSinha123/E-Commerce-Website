package model.dao;

import model.User;

public class UserDAO {

    public boolean register(User user) {
        // TEMPORARY (no DB yet)
        return user != null
                && user.getName() != null
                && user.getEmail() != null
                && user.getPassword() != null;
    }

    public User login(String email, String password) {
        // TEMPORARY (no DB yet)
        if (email.equals("admin@gmail.com") && password.equals("1234")) {
            User user = new User();
            user.setEmail(email);
            return user;
        }
        return null;
    }
}
