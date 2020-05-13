package org.fundacionjala.trello.throwables;

public class MissingConfigurationsException extends RuntimeException {

    public MissingConfigurationsException(final String message) {
        super(message);
    }
}
