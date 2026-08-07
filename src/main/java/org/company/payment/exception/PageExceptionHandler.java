package org.company.payment.exception;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class PageExceptionHandler {

    @ExceptionHandler(AccessDeniedException.class)
    public String handlerAccessDenied(AccessDeniedException ex, Model model)
    {
        model.addAttribute("error", ex.getMessage());
        return "access-denied";
    }
}
