package org.fundacionjala.trello.config;

import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.trello.context.Context;
import org.fundacionjala.trello.utils.Mapper;
import org.fundacionjala.trello.utils.RequestSpecUtil;

import java.util.Map;

import static io.restassured.RestAssured.given;

/**
 * Gives options available to sending a request.
 */
public class RequestManagerRestAssured implements IRequestManager {

    private final Context context;

    public RequestManagerRestAssured(final Context context) {
        this.context = context;
    }

    /**
     * Sets authentication header to base request specification.
     *
     * @param username account username.
     */
    public void withAuthentication(final String username) {
        RequestSpecification reqSpec = RequestSpecUtil.build(username);
        context.setReqSpec(reqSpec);
    }

    /**
     * Sets request specification base without authentication.
     */
    public void withoutAuthentication() {
        RequestSpecification reqSpec = RequestSpecUtil.build();
        context.setReqSpec(reqSpec);
    }

    /**
     * Sets the parameters that'll be in the base request specification.
     *
     * @param params contains the parameter names and their values to send with the request.
     * @return RequestManager object.
     */
    public RequestManagerRestAssured params(final Map<String, String> params) {
        context.getReqSpec().params(mapOut(params));
        return this;
    }

    /**
     * Sets the body that'll be in the base request specification.
     *
     * @param jsonData contains the string body to send.
     * @return RequestManager object.
     */
    public RequestManagerRestAssured body(final String jsonData) {
        context.getReqSpec().body(jsonData);
        return this;
    }

    /**
     * Sends a GET request to an <code>endpoint</code>.
     *
     * @param endpoint The path to send the request to.
     * @return The response of the request.
     */
    public Response get(final String endpoint) {
        return given(context.getReqSpec()).when().get(mapOut(endpoint));
    }

    /**
     * Sends a DELETE request to an <code>endpoint</code>.
     *
     * @param endpoint The path to send the request to.
     * @return The response of the request.
     */
    public Response delete(final String endpoint) {
        return given(context.getReqSpec()).when().delete(mapOut(endpoint));
    }

    /**
     * Sends a POST request to an <code>endpoint</code>.
     *
     * @param endpoint The path to send the request to.
     * @return The response of the request.
     */
    public Response post(final String endpoint) {
        return given(context.getReqSpec()).when().post(mapOut(endpoint));
    }

    /**
     * Sends a PUT request to an <code>endpoint</code>.
     *
     * @param endpoint The path to send the request to.
     * @return The response of the request.
     */
    public Response put(final String endpoint) {
        return given(context.getReqSpec()).when().put(mapOut(endpoint));
    }

    private String mapOut(final String endpoint) {
        return Mapper.replaceData(endpoint, context.getResponses());
    }

    private Map<String, String> mapOut(final Map<String, String> params) {
        return Mapper.replaceData(params, context.getResponses());
    }
}
