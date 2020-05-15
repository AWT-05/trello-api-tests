package org.fundacionjala.trello.utils;

import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.trello.config.Environment;

/**
 * Groups utility methods to build request spec base object.
 */
public final class RequestSpecUtils {

    private static final String AUTHORIZATION_KEY = "key";
    private static final String AUTHORIZATION_TOKEN = "token";

    /**
     * A private constructor for RequestSpecUtils utility class.
     */
    private RequestSpecUtils() {

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

    /**
     * Builds base request specification using API key and token.
     *
     * @return base request specification.
     */
    public static RequestSpecification buildWithAuth() {
        String baseUri = Environment.getInstance().getBaseUri();
        String apiKey = Environment.getInstance().getApiKey();
        String apiToken = Environment.getInstance().getApiToken();

        return new RequestSpecBuilder().setBaseUri(baseUri)
                .setContentType(ContentType.JSON)
                .addQueryParam(AUTHORIZATION_KEY, apiKey)
                .addQueryParam(AUTHORIZATION_TOKEN, apiToken).build();
    }

    /**
     * Builds base request specification using an API key.
     *
     * @return base request specification.
     */
    public static RequestSpecification buildOnlyApiKey() {
        String baseUri = Environment.getInstance().getBaseUri();
        String apiKey = Environment.getInstance().getApiKey();

        return new RequestSpecBuilder().setBaseUri(baseUri)
                .setContentType(ContentType.JSON)
                .addQueryParam(AUTHORIZATION_KEY, apiKey).build();
    }

    /**
     * Builds base request specification using a token.
     *
     * @return base request specification.
     */
    public static RequestSpecification buildOnlyToken() {
        String baseUri = Environment.getInstance().getBaseUri();
        String apiToken = Environment.getInstance().getApiToken();

        return new RequestSpecBuilder().setBaseUri(baseUri)
                .setContentType(ContentType.JSON)
                .addQueryParam(AUTHORIZATION_TOKEN, apiToken).build();
    }
}
