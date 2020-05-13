package org.fundacionjala.trello.utils;

public enum Keys {
    BOARD("board"),
    LABEL("label"),
    LIST("list"),
    ORGANIZATION("organization");

    private final String value;

    Keys(final String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
