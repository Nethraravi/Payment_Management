package org.company.payment.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.company.payment.enums.Role;

import java.time.LocalDateTime;

@Getter
@AllArgsConstructor
public class UserResponseDTO {
    private Long id;
    private String username;
    private String fullName;
    private Role role;
    private Boolean enabled;
    private LocalDateTime createdAt;
}
