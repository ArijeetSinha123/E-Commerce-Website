package src.model.dao;

import src.model.User;

public class UserDAO {

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
