package org.company.payment.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.company.payment.dto.PaymentRequestDTO;
import org.company.payment.dto.PaymentResponseDTO;
import org.company.payment.entity.User;
import org.company.payment.service.PaymentService;
import org.springframework.web.bind.annotation.*;

import javax.management.remote.rmi.RMIConnection;
import java.util.List;

@RestController
@RequestMapping("/payments")
@RequiredArgsConstructor
public class PaymentController {

    private final PaymentService paymentService;


    @PostMapping("/create")
    public PaymentResponseDTO createPayment(@Valid @RequestBody PaymentRequestDTO requestDTO)
    {
        System.out.println("PaymentController.createPayment() EXECUTED");
        return paymentService.createPayment(requestDTO);
    }

    @GetMapping
    public List<PaymentResponseDTO> getAllPayments()
    {
        return paymentService.getAllPayments();
    }

    @PutMapping("/{id}")
    public PaymentResponseDTO updatePayment(@PathVariable("id") Long id, @Valid @RequestBody PaymentRequestDTO requestDTO)
    {
        return paymentService.updatePayment(id, requestDTO);
    }

    @GetMapping("/{id}")
    public PaymentResponseDTO getPaymentById(@PathVariable("id") Long id)
    {
        System.out.println("GET PAYMENT BY ID EXECUTED: "+id);
        return paymentService.getPaymentById(id);
    }

    @DeleteMapping("/{id}")
    public void deletePayment(@PathVariable("id") Long id)
    {
        paymentService.deletePayment(id);
    }
}
