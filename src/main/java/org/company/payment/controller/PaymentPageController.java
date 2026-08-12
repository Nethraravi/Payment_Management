package org.company.payment.controller;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.company.payment.dto.PaymentRequestDTO;
import org.company.payment.dto.PaymentResponseDTO;
import org.company.payment.entity.User;
import org.company.payment.enums.Role;
import org.company.payment.exception.AccessDeniedException;
import org.company.payment.service.PaymentService;
import org.company.payment.validation.OnCreate;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class PaymentPageController {

    private final PaymentService paymentService;

    private void checkAdmin(HttpSession session)
    {
        Role role = (Role) session.getAttribute("role");

        if(role != Role.ADMIN)
        {
            throw new AccessDeniedException("Access denied. Only administrators can perform this action.");
        }
    }

    @GetMapping("/payments-page")
    public String showPaymentsPage(@RequestParam(name="success", required = false) String success, Model model, HttpSession session, HttpServletResponse response)
    {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("payments", paymentService.getAllPayments(loggedInUser));

        if("created".equals(success))
        {
            model.addAttribute("successMessage","Payment created successfully!");
        }
        return "payments";
    }

    @GetMapping("/payments-page/receipt/{id}")
    public ResponseEntity<Resource> viewReceipt(@PathVariable("id") Long id)
    {
        return paymentService.viewReceipt(id);
    }

    @GetMapping("/payments-page/edit/{id}")
    public String showEditPaymentPage(@PathVariable("id") Long id, Model model, HttpSession session, HttpServletResponse response)
    {
        checkAdmin(session);
        PaymentResponseDTO payment = paymentService.getPaymentById(id);
        model.addAttribute("payment", payment);
        model.addAttribute("paymentId", id);
        System.out.println("DEBUG paymentId = "+id);
        return "edit-payment";
    }

    @PostMapping("/payments-page/edit/{id}")
    public String updatePayment(@PathVariable("id") Long id, @Valid @ModelAttribute("payment") PaymentRequestDTO requestDTO, BindingResult bindingResult, Model model, HttpSession session)
    {
        System.out.println("DEBUG: updatePayment() called, id = " + id);
        System.out.println("DEBUG validation errors = " + bindingResult.getFieldErrors());
        checkAdmin(session);
        if(bindingResult.hasErrors())
        {
            model.addAttribute("payment", requestDTO);
            model.addAttribute("paymentId", id);
            model.addAttribute("errors",bindingResult.getFieldErrors().stream().collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage, (existing, replacement) -> existing)));
            return "edit-payment";
        }
        paymentService.updatePayment(id, requestDTO);
        return "redirect:/payments-page";
    }

    @PostMapping("/payments-page/delete/{id}")
    public String deletePayment(@PathVariable("id") Long id, HttpSession session)
    {
        checkAdmin(session);
        paymentService.deletePayment(id);
        return "redirect:/payments-page";
    }

    @GetMapping("/payments-page/create")
    public String showCreatePaymentPage(Model model)
    {
        model.addAttribute("payment", new PaymentRequestDTO());
        return "create-payment";
    }

    @PostMapping("/payments-page/create")
    public String createPayment(@Validated(OnCreate.class) @ModelAttribute("payment") PaymentRequestDTO requestDTO, BindingResult bindingResult, Model model, HttpSession session)
    {
        if(bindingResult.hasErrors())
        {
            model.addAttribute("errors", bindingResult.getFieldErrors().stream().collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage)));
            model.addAttribute("payment", requestDTO);
            return "create-payment";
        }
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        paymentService.createPayment(requestDTO, loggedInUser);
        return "redirect:/payments-page?success=created";
    }
}
