package org.company.payment.service;

import lombok.RequiredArgsConstructor;
import org.company.payment.entity.User;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
@Service
@RequiredArgsConstructor
public class EmailService {
    private final JavaMailSender mailSender;
    private static final Logger logger = LoggerFactory.getLogger(EmailService.class);

    public void sendTestEmail()
    {
            SimpleMailMessage message = new SimpleMailMessage();

            message.setFrom("nethra161102@gmail.com");
            message.setTo("nethra161102@gmail.com");
            message.setSubject("Payment Management - Test Email");
            message.setText("Email notification is working successfully!");

            mailSender.send(message);
    }

    public void sendUserCreatedEmail(User user, User createdBy)
    {
        SimpleMailMessage message = new SimpleMailMessage();

        message.setFrom("nethra161102@gmail.com");
        message.setTo("nethra161102@gmail.com");

        message.setSubject("Payment Management - New User Created");
        message.setText("A new user has been created in Payment Management System. \n\n"+"Username: "+user.getUsername()+"\n"+"Full Name: "+user.getFullName()+"\n"+"Role: "+user.getRole()+"\n"+"Created By: "+createdBy.getUsername());
        mailSender.send(message);
    }

    public void sendUserStatusChangedEmail(User user, User changedBy) {
        try{
        SimpleMailMessage message = new SimpleMailMessage();

        message.setFrom("nethra161102@gmail.com");
        message.setTo("nethra161102@gmail.com");

        message.setSubject("Payment Management - User Status Updated");
        String status = user.getEnabled() ? "Enabled" : "Disabled";

        message.setText("A user's account status has been updated.\n\n" + "Username: " + user.getUsername() + "\n" + "Full Name: " + user.getFullName() + "\n" + "New Status: " + status + "\n" + "Changed By: " + changedBy.getUsername());
        mailSender.send(message);
    }
        catch (Exception e)
        {
            logger.error("Failed to send user status email for user '{}'.",user.getUsername(),e);
        }
    }
}

