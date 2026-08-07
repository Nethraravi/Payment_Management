package org.company.payment.exception;

public class InvalidOperationException extends RuntimeException {
    public  InvalidOperationException(String message)
    {
        super(message);
    }
}
