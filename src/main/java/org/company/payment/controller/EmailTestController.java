package org.company.payment.controller;

import lombok.RequiredArgsConstructor;
import org.company.payment.service.EmailService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequiredArgsConstructor
public class EmailTestController {

    private final EmailService emailService;

    @GetMapping("/test-email")
    @ResponseBody
    public String testEmail()
    {
        emailService.sendTestEmail();
        return "Email sent successfully!";
    }
}
