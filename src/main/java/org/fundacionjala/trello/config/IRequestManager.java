package org.fundacionjala.trello.config;

import io.restassured.response.Response;

import java.util.Map;

public interface IRequestManager {

    /**
     * Sets authentication header to base request specification.
     */
    void authenticate();

    /**
     * Sets request specification base without authentication.
     */
    void noAuthenticate();

    /**
     * Sets the parameters that'll be in the base request specification.
     *
     * @param params contains the parameter names and their values to send with the request.
     * @return RequestManager object.
     */
    IRequestManager params(Map<String, String> params);

    /**
     * Sets the query parameters that'll be in the base request specification.
     *
     * @param params contains the parameter names and their values to send with the request.
     * @return RequestManager object.
     */
    IRequestManager queryParams(final Map<String, String> params);

    /**
     * Sets the body that'll be in the base request specification.
     *
     * @param jsonData contains the string body to send.
     * @return RequestManager object.
     */
    IRequestManager body(String jsonData);

    /**
     * Sends a GET request to an <code>endpoint</code>.
     *
     * @param endpoint The path to send the request to.
     * @return The response of the request.
     */
    Response get(String endpoint);

    /**
     * Sends a DELETE request to an <code>endpoint</code>.
     *
     * @param endpoint The path to send the request to.
     * @return The response of the request.
     */
    Response delete(String endpoint);

    /**
     * Sends a POST request to an <code>endpoint</code>.
     *
     * @param endpoint The path to send the request to.
     * @return The response of the request.
     */
    Response post(String endpoint);

    /**
     * Sends a PUT request to an <code>endpoint</code>.
     *
     * @param endpoint The path to send the request to.
     * @return The response of the request.
     */
    Response put(String endpoint);
}
