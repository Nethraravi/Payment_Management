package org.company.payment.controller;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.company.payment.dto.UserRequestDTO;
import org.company.payment.dto.UserResponseDTO;
import org.company.payment.entity.User;
import org.company.payment.enums.Role;
import org.company.payment.exception.AccessDeniedException;
import org.company.payment.exception.InvalidOperationException;
import org.company.payment.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class UserPageController {
    private final UserService userService;

    @GetMapping("/users-page")
    public String showUserPage(@RequestParam(name = "success", required = false) String success, @RequestParam(name="error", required = false) String error, HttpSession session, Model model)
    {
        if ("statusUpdated".equals(success))
        {
            model.addAttribute("successMessage","User status updated successfully!");
        }

        if(error != null)
        {
            model.addAttribute("errorMessage", error);
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if(loggedInUser.getRole()!= Role.ADMIN)
        {
            throw new AccessDeniedException("Access denied. Only administrators can manage users.");
        }

        List<UserResponseDTO> users = userService.getAllUsers();
        model.addAttribute("users", users);

        return "users";
    }

    @GetMapping("/users-page/create")
    public String showCreateUserPage(HttpSession session, Model model)
    {
        //Role role = (Role) session.getAttribute("role");

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if(loggedInUser.getRole()!= Role.ADMIN)
        {
            throw new AccessDeniedException("Access denied. Only administrators can manage users.");
        }

        model.addAttribute("user", new UserRequestDTO());
        return "create-user";
    }

    @PostMapping("/users-page/create")
    public String createUser(@Valid @ModelAttribute("user") UserRequestDTO requestDTO, BindingResult bindingResult, Model model, HttpSession session)
    {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if(bindingResult.hasErrors())
        {
            model.addAttribute("user",requestDTO);
            return "create-user";
        }

        if(loggedInUser.getRole()!=Role.ADMIN)
        {
            throw new AccessDeniedException("Access denied. Only administrators can manage users.");
        }
        userService.createUser(requestDTO);
        return "redirect:/users-page?success=update";
    }

    @GetMapping("/users-page/edit/{id}")
    public String showEditUserPage(@PathVariable("id") Long id, HttpSession session, Model model)
    {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if(loggedInUser == null)
        {
            return "redirect:/login";
        }

        if(loggedInUser.getRole() != Role.ADMIN)
        {
            throw new AccessDeniedException("Access denied. Only administrators can manage users.");
        }

        model.addAttribute("user", userService.getUserById(id));
        return "edit-user";
    }

    @PostMapping("/users-page/edit/{id}")
    public String updateUser(@PathVariable("id") Long id, @ModelAttribute("user") UserRequestDTO requestDTO, HttpSession session, Model model)
    {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if(loggedInUser == null)
        {
            return "redirect:/login";
        }

        if(loggedInUser.getRole() != Role.ADMIN)
        {
            throw new AccessDeniedException("Access denied. Only administrators can manage users.");
        }

        try
        {
            userService.updateUser(id, requestDTO, loggedInUser);
            return "redirect:/users-page?success=updated";
        }
        catch (InvalidOperationException e)
        {
            requestDTO.setId(id);
            model.addAttribute("error", e.getMessage());
            model.addAttribute("user", requestDTO);
            return "edit-user";
        }
    }

    @PostMapping("/users-page/toggle/{id}")
    public String toggleUser(@PathVariable("id") Long id, HttpSession session)
    {
        User loggedInUser =(User) session.getAttribute("loggedInUser");

        if(loggedInUser == null)
        {
            return "redirect:/login";
        }

        if(loggedInUser.getRole()!=Role.ADMIN)
        {
            throw new AccessDeniedException("Only administrators can perform this action.");
        }

        try
        {
            userService.toggleUserStatus(id, loggedInUser);
            return "redirect:/users-page?success=statusUpdated";
        }
        catch (InvalidOperationException e)
        {
            return "redirect:/users-page?error=" + URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8);
        }
    }
}
