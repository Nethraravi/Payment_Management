package org.company.payment.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.company.payment.enums.Role;

@Getter
@Setter
@NoArgsConstructor
public class UserRequestDTO {

    private Long id;

    @NotBlank
    private String username;

    @NotBlank
    private String password;

    @NotBlank
    private String fullName;

    @NotNull
    private Role role;

    private Boolean enabled = true;
}
