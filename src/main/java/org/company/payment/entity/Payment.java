package org.company.payment.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.company.payment.enums.PaymentMethod;
import org.company.payment.enums.PaymentStatus;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name="payments")
@Getter
@Setter
@NoArgsConstructor
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private BigDecimal amount;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by")
    private User createdBy;

    @Enumerated(EnumType.STRING)
    private PaymentMethod paymentMethod;

    @Enumerated(EnumType.STRING)
    private PaymentStatus status;
    private LocalDateTime paymentDate;

    @Column(name="receipt_path")
    private String receiptPath;


    public Payment(BigDecimal amount, PaymentMethod paymentMethod, PaymentStatus status, LocalDateTime paymentDate)
    {
        this.amount=amount;
        this.paymentMethod=paymentMethod;
        this.status=status;
        this.paymentDate=paymentDate;
    }

}
