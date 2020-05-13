package org.fundacionjala.trello.throwables;

public class InitializationException extends ExceptionInInitializerError {

    public InitializationException(final String message) {
        super(message);
        System.exit(1);
    }
}
