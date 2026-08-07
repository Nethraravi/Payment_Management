package org.company.payment.exception;

public class InvalidCredentialsException extends RuntimeException{

    public InvalidCredentialsException(String message)
    {
        super(message);
    }
}
