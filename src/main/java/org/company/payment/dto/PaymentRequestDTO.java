package org.company.payment.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.company.payment.enums.PaymentMethod;
import org.company.payment.enums.PaymentStatus;
import org.company.payment.validation.OnCreate;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
public class PaymentRequestDTO {

    @NotNull(message = "Amount is required", groups = OnCreate.class)
    @DecimalMin(value="0.01", message = "Amount must be greater than zero", groups = OnCreate.class)
    private BigDecimal amount;

    @NotNull(message = "Payment method is required", groups = OnCreate.class)
    private PaymentMethod paymentMethod;

    @NotNull(message = "Status is required")
    private PaymentStatus status;

    private MultipartFile receipt;

}
