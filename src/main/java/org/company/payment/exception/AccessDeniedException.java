package org.company.payment.exception;

public class AccessDeniedException extends RuntimeException{
    public AccessDeniedException(String message)
    {
        super(message);
    }
}
