package org.fundacionjala.trello.client;

import io.restassured.response.Response;
import org.fundacionjala.trello.context.Context;

import java.util.Map;

public interface IRequestManager {

    /**
     * Initialize the request specification, cleaning any parameters.
     *
     * @param context when save the request specification.
     * @return the request manager object.
     */
    IRequestManager init(Context context);

    /**
     * Sets the parameters that'll be in the base request specification.
     *
     * @param params contains the parameter names and their values to send with the request.
     * @return the request manager object.
     */
    IRequestManager params(Map<String, String> params);

    /**
     * Sets the query parameters that'll be in the base request specification.
     *
     * @param params contains the parameter names and their values to send with the request.
     * @return the request manager object.
     */
    IRequestManager queryParams(Map<String, String> params);

    /**
     * Sets the body that'll be in the base request specification.
     *
     * @param jsonData contains the string body to send.
     * @return the request manager object.
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
