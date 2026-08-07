package org.company.payment.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.company.payment.enums.PaymentMethod;
import org.company.payment.enums.PaymentStatus;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@AllArgsConstructor
public class PaymentResponseDTO {

    private Long id;
    private BigDecimal amount;
    private PaymentMethod paymentMethod;
    private PaymentStatus status;
    private LocalDateTime paymentDate;
    private String createdBy;
    private String receiptPath;
}