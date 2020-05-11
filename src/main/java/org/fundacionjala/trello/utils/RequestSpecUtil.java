package org.fundacionjala.trello.utils;

import io.restassured.builder.RequestSpecBuilder;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.trello.config.Environment;

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
     * @return base request specification.
     */
    public static RequestSpecification buildWithAuth() {
        String baseUri = Environment.getInstance().getBaseUri();
        String apiKey = Environment.getInstance().getApiKey();
        String apiToken = Environment.getInstance().getApiToken();

        return new RequestSpecBuilder().setBaseUri(baseUri)
                .setContentType("application/json")
                .addQueryParam("key", apiKey)
                .addQueryParam("token", apiToken).build();
    }

    /**
     * Builds base request specification without authentication header.
     *
     * @return base request specification.
     */
    public static RequestSpecification build() {
        String baseUri = Environment.getInstance().getBaseUri();
        return new RequestSpecBuilder().setBaseUri(baseUri).build();
    }
}
