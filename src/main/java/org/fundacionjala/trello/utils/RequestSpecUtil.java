package org.fundacionjala.trello.utils;

import io.restassured.specification.RequestSpecification;

/**
 * Groups utility methods to build request spec base object.
 */
public final class RequestSpecUtil {

    /**
     * Private constructor for RequestSpecUtils utility class.
     */
    private RequestSpecUtil() {

    }

    /**
     * Builds base request specification for a username.
     *
     * @param username account username.
     * @return base request specification.
     */
    public static RequestSpecification build(final String username) {
        // To do.
        return null;
    }

    /**
     * Builds base request specification without authentication header.
     *
     * @return base request specification.
     */
    public static RequestSpecification build() {
        // To do.
        return null;
    }
}
