package org.fundacionjala.trello.throwables;

public class CustomException extends Exception {

    public CustomException(String message) {
        super(message);
    }
    public CustomException(String message, String stop) {
        super(message);
        System.exit(1);
    }
}
