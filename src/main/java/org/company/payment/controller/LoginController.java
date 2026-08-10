package org.company.payment.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.company.payment.entity.User;
import org.company.payment.service.LoginService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class LoginController {
    private final LoginService loginService;
    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    @GetMapping("/login")
    public String showLoginPage()
    {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam("username") String username, @RequestParam("password") String password, Model model, HttpSession session)
    {
        try
        {
            User user = loginService.login(username, password);
            session.setAttribute("loggedInUser", user);
            session.setAttribute("role", user.getRole());
            logger.info("User '{}' logged in successfully.", user.getUsername());
            return "redirect:/payments-page";
        }
        catch (Exception e)
        {
            logger.warn("Failed login attempt for username '{}'.", username);
            model.addAttribute("error", e.getMessage());
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session)
    {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if(loggedInUser != null)
        {
            logger.info("User '{}' logged out successfully.", loggedInUser.getUsername());
        }
        session.invalidate();
        return "redirect:/login";
    }
}
