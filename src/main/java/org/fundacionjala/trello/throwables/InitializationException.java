package org.fundacionjala.trello.throwables;

public class InitializationException extends ExceptionInInitializerError {

    public InitializationException(String message) {
        super(message);
        System.exit(1);
    }
}
