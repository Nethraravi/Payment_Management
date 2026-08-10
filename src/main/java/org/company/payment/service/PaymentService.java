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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

    private static final Path UPLOAD_DIRECTORY = Paths.get("C:\\Users\\nethra.r\\IdeaProjects\\payment-management\\uploads");
    private static final Logger logger = LoggerFactory.getLogger(PaymentService.class);

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
                Path uploadPath = UPLOAD_DIRECTORY;
                if (!Files.exists(uploadPath))
                {
                    Files.createDirectories(uploadPath);
                }
                Path filePath = uploadPath.resolve(uniqueFileName);
                receipt.transferTo(filePath.toFile());
                logger.info("Receipt '{}' uploaded successfully as '{}'",
                        fileName,
                        uniqueFileName);
            }
            catch (IOException e)
            {
                logger.error("Failed to upload receipt '{}'", receipt.getOriginalFilename(), e);
                throw new RuntimeException("Failed to upload receipt.", e);
            }
        }
        Payment payment = new Payment(requestDTO.getAmount(),requestDTO.getPaymentMethod(),requestDTO.getStatus(),LocalDateTime.now());
        payment.setReceiptPath(uniqueFileName);
        payment.setCreatedBy(loggedInUser);
        Payment savedPayment = paymentRepository.savePayment(payment);
        logger.info("Payment {} created successfully", payment.getId());
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

        logger.info("Payment {} updated successfully", payment.getId());
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

        logger.info("Payment {} deleted successfully", payment.getId());
        paymentRepository.deletePayment(payment);
    }

    public ResponseEntity<Resource> viewReceipt(Long id)
    {
        Payment payment = paymentRepository.findPaymentById(id);

        if (payment == null)
        {
            throw new PaymentNotFoundException("Payment not found with id: " + id);
        }

        if (payment.getReceiptPath() == null || payment.getReceiptPath().isBlank())
        {
            throw new RuntimeException("Receipt not found.");
        }

        try
        {
            System.out.println("Receipt Path in DB: " + payment.getReceiptPath());
            Path filePath = UPLOAD_DIRECTORY.resolve(payment.getReceiptPath());

            System.out.println("Absolute Path: " + filePath.toAbsolutePath());
            System.out.println("Exists: " + Files.exists(filePath));
            Resource resource = new UrlResource(filePath.toUri());

            if (!resource.exists())
            {
                throw new RuntimeException("Receipt file not found.");
            }

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_PDF)
                    .header(HttpHeaders.CONTENT_DISPOSITION,
                            "inline; filename=\"" + payment.getReceiptPath() + "\"")
                    .body(resource);
        }
        catch (IOException e)
        {
            throw new RuntimeException("Unable to read receipt.", e);
        }
    }
}
