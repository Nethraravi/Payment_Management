package org.company.payment.service;

import lombok.RequiredArgsConstructor;
import org.company.payment.entity.User;
import org.company.payment.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.company.payment.exception.InvalidCredentialsException;

@Service
@RequiredArgsConstructor
public class LoginService {

    private final UserRepository userRepository;

    public User login(String username, String password)
    {
        User user = userRepository.findByUsername(username);

        if(user == null || !user.getPassword().equals(password))
        {
            throw new InvalidCredentialsException("Invalid username or password");
        }

        if(!user.getEnabled())
        {
            throw new RuntimeException("Your account has been disabled.");
        }

        if(!user.getEnabled())
        {
            throw new InvalidCredentialsException("Your account has been disabled. Please contact the administrator.");
        }

        return user;
    }
}
