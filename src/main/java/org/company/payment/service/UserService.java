package org.company.payment.service;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.company.payment.dto.UserRequestDTO;
import org.company.payment.dto.UserResponseDTO;
import org.company.payment.entity.User;
import org.company.payment.exception.InvalidOperationException;
import org.company.payment.repository.UserRepository;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final EmailService emailService;
    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    public User login(String username, String password)
    {
        User user = userRepository.findByUsername(username);

        if(user == null || !user.getPassword().equals(password))
        {
            throw new RuntimeException("Invalid username or password");
        }
        return user;
    }

    @Transactional
    public void createUser(UserRequestDTO requestDTO, User loggedInUser)
    {
        User existingUser = userRepository.findByUsername(requestDTO.getUsername());
        if(existingUser != null)
        {
            throw new RuntimeException("Username already exists");
        }
        User user = new User();

        user.setUsername(requestDTO.getUsername());
        user.setPassword(requestDTO.getPassword());
        user.setFullName(requestDTO.getFullName());
        user.setRole(requestDTO.getRole());
        user.setEnabled(true);
        userRepository.save(user);
        logger.info("Administrator '{}' created user '{}' with role {}.", loggedInUser.getUsername(), user.getUsername(), user.getRole());
        emailService.sendUserCreatedEmail(user, loggedInUser);
    }

    public List<UserResponseDTO> getAllUsers()
    {
        return userRepository.findAll().stream().map(this::convertToResponseDTO).toList();
    }

    public long totalUsers()
    {
        return userRepository.totalUsers();
    }

    private UserResponseDTO convertToResponseDTO(User user)
    {
        return new UserResponseDTO(user.getId(),user.getUsername(),user.getFullName(),user.getRole(),user.getEnabled(),user.getCreatedAt());
    }

    public UserRequestDTO getUserById(Long id, User loggedInUser)
    {
        User user = userRepository.findById(id);

        if(user == null)
        {
            logger.warn("Administrator '{}' attempted to access non-existing user with id {}.",loggedInUser.getUsername(), id);
            throw new RuntimeException("User not found");
        }

        UserRequestDTO dto = new UserRequestDTO();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setFullName(user.getFullName());
        dto.setRole(user.getRole());
        return dto;
    }

    @Transactional
    public void updateUser(Long id, UserRequestDTO requestDTO, User loggedInUser)
    {
        User user = userRepository.findById(id);

        if(user == null)
        {
            logger.warn("Administrator '{}' attempted to change their own role.", loggedInUser.getUsername());
            throw new RuntimeException("User not found");
        }

        if(loggedInUser.getId().equals(id) && loggedInUser.getRole() != requestDTO.getRole())
        {
            logger.warn("Administrator '{}' attempted to update non-existing user with id {}.", loggedInUser.getUsername(), id);
            throw new InvalidOperationException("You cannot change your own role.");
        }

        user.setUsername(requestDTO.getUsername());
        user.setFullName(requestDTO.getFullName());
        user.setRole(requestDTO.getRole());

        if(requestDTO.getPassword() != null && !requestDTO.getPassword().isBlank())
        {
            user.setPassword(requestDTO.getPassword());
        }
        logger.info("Administrator '{}' updated user '{}' successfully.", loggedInUser.getUsername(), user.getUsername());
    }

    @Transactional
    public void toggleUserStatus(Long id, User loggedInUser)
    {
        User user = userRepository.findById(id);

        if(user == null)
        {
            throw new RuntimeException("User not found");
        }

        if(loggedInUser.getId().equals(id))
        {
            logger.warn("Administrator '{}' attempted to disable their own account.", loggedInUser.getUsername());
            throw new InvalidOperationException("You cannot disable your own account.");
        }

        user.setEnabled(!user.getEnabled());
        logger.info("Administrator '{}' {} user '{}'.", loggedInUser.getUsername(), user.getEnabled() ? "ENABLED" : "DISABLED", user.getUsername());
        emailService.sendUserStatusChangedEmail(user, loggedInUser);
    }
}
