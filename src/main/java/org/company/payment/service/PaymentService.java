package org.company.payment.service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.company.payment.dto.PaymentRequestDTO;
import org.company.payment.dto.PaymentResponseDTO;
import org.company.payment.dto.UserResponseDTO;
import org.company.payment.entity.Payment;
import org.company.payment.entity.User;
import org.company.payment.enums.Role;
import org.company.payment.exception.PaymentNotFoundException;
import org.company.payment.repository.PaymentRepository;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PaymentService {

    private final PaymentRepository paymentRepository;

    @Transactional  //--> used for rest api
    public PaymentResponseDTO createPayment(PaymentRequestDTO requestDTO)
    {
        Payment payment = new Payment(requestDTO.getAmount(),requestDTO.getPaymentMethod(),requestDTO.getStatus(),LocalDateTime.now());
        Payment savedPayment = paymentRepository.savePayment(payment);
        return convertToResponseDTO(savedPayment);
    }

    @Transactional //--> used by jsp which has session based login
    public PaymentResponseDTO createPayment(PaymentRequestDTO requestDTO, User loggedInUser)
    {
        String uniqueFileName = null;
        MultipartFile receipt = requestDTO.getReceipt();
        if (receipt != null && !receipt.isEmpty())
        {
            try
            {
                String fileName=receipt.getOriginalFilename();
                uniqueFileName = UUID.randomUUID() + "_" + fileName;
                Path uploadPath = Paths.get("uploads");
                if (!Files.exists(uploadPath))
                {
                    Files.createDirectories(uploadPath);
                }
                Path filePath = uploadPath.resolve(uniqueFileName);
                receipt.transferTo(filePath.toFile());
            }
            catch (IOException e)
            {
                throw new RuntimeException("Failed to upload receipt.", e);
            }
        }
        Payment payment = new Payment(requestDTO.getAmount(),requestDTO.getPaymentMethod(),requestDTO.getStatus(),LocalDateTime.now());
        payment.setReceiptPath(uniqueFileName);
        payment.setCreatedBy(loggedInUser);
        Payment savedPayment = paymentRepository.savePayment(payment);
        return convertToResponseDTO(savedPayment);
    }

    public List<PaymentResponseDTO> getAllPayments() //--> used for restAPI (PaymentController)
    {
        return paymentRepository.findAllPayments()
                .stream()
                .map(this::convertToResponseDTO)
                .toList();
    }

    public List<PaymentResponseDTO> getAllPayments(User loggedInUSer) // --> used for jsp (PaymentPageController)
    {
        List<Payment> payments;

        if(Role.ADMIN.equals(loggedInUSer.getRole()))
        {
            payments=paymentRepository.findAllPayments();
        }
        else
        {
            payments = paymentRepository.findPaymentsByUser(loggedInUSer);
        }
        return payments.stream().map(this::convertToResponseDTO).toList();
    }

    private PaymentResponseDTO convertToResponseDTO(Payment payment)
    {
        String createdBy = payment.getCreatedBy()!=null?payment.getCreatedBy().getFullName():"-";
        return new PaymentResponseDTO(payment.getId(), payment.getAmount(), payment.getPaymentMethod(), payment.getStatus(), payment.getPaymentDate(), createdBy, payment.getReceiptPath());
    }

    private UserResponseDTO convertToResponseDTO(User user)
    {
        return new UserResponseDTO(user.getId(),user.getUsername(),user.getFullName(),user.getRole(),user.getEnabled(), user.getCreatedAt());
    }

    @Transactional
    public PaymentResponseDTO updatePayment(Long id, PaymentRequestDTO requestDTO)
    {
        Payment payment = paymentRepository.findPaymentById(id);

        if(payment == null)
        {
            throw new RuntimeException("Payment not found with id: "+id);
        }
        payment.setAmount(requestDTO.getAmount());
        payment.setPaymentMethod(requestDTO.getPaymentMethod());
        payment.setStatus(requestDTO.getStatus());

        return convertToResponseDTO(payment);
    }

    public PaymentResponseDTO getPaymentById(Long id)
    {
        Payment payment = paymentRepository.findPaymentById(id);

        if(payment == null)
        {
            throw new PaymentNotFoundException("Payment not found with id: "+id);
        }
        return convertToResponseDTO(payment);
    }

    @Transactional
    public void deletePayment(Long id)
    {
        Payment payment = paymentRepository.findPaymentById(id);
        if(payment == null)
        {
            throw new PaymentNotFoundException("Payment not found with id: "+id);
        }

        paymentRepository.deletePayment(payment);
    }
}
