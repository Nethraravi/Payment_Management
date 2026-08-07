package org.company.payment.service;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.company.payment.dto.UserRequestDTO;
import org.company.payment.dto.UserResponseDTO;
import org.company.payment.entity.User;
import org.company.payment.exception.InvalidOperationException;
import org.company.payment.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

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
    public void createUser(UserRequestDTO requestDTO)
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
        user.setCreatedAt(LocalDateTime.now());

        userRepository.save(user);
    }

    public List<UserResponseDTO> getAllUsers()
    {
        return userRepository.findAll().stream().map(this::convertToResponseDTO).toList();
    }

    private UserResponseDTO convertToResponseDTO(User user)
    {
        return new UserResponseDTO(user.getId(),user.getUsername(),user.getFullName(),user.getRole(),user.getEnabled(),user.getCreatedAt());
    }

    public UserRequestDTO getUserById(Long id)
    {
        User user = userRepository.findById(id);

        if(user == null)
        {
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
            throw new RuntimeException("User not found");
        }

        if(loggedInUser.getId().equals(id) && loggedInUser.getRole() != requestDTO.getRole())
        {
            throw new InvalidOperationException("You cannot change your own role.");
        }

        user.setUsername(requestDTO.getUsername());
        user.setFullName(requestDTO.getFullName());
        user.setRole(requestDTO.getRole());

        if(requestDTO.getPassword() != null && !requestDTO.getPassword().isBlank())
        {
            user.setPassword(requestDTO.getPassword());
        }
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
            throw new InvalidOperationException("You cannot disable your own account.");
        }

        user.setEnabled(!user.getEnabled());
    }
}
