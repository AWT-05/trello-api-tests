package org.fundacionjala.trello.throwables;

public class MissingConfigurationsError extends ExceptionInInitializerError {

    public MissingConfigurationsError(final String message) {
        super(message);
        System.exit(1);
    }
}
