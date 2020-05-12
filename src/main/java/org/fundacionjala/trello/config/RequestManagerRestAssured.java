package org.fundacionjala.trello.config;

import io.restassured.RestAssured;
import io.restassured.filter.log.RequestLoggingFilter;
import io.restassured.filter.log.ResponseLoggingFilter;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.trello.context.Context;
import org.fundacionjala.trello.utils.Mapper;
import org.fundacionjala.trello.utils.RequestSpecUtils;

import java.util.Map;

import static io.restassured.RestAssured.given;

/**
 * Gives options available to sending a request.
 */
public class RequestManagerRestAssured implements IRequestManager {

    private RequestSpecification reqSpec;
    private Context context;

    public RequestManagerRestAssured() {
        reqSpec = RequestSpecUtils.build();
        context = new Context();
    }

    /**
     * Initialize the request specification, cleaning any parameters.
     *
     * @param context when save the request specification.
     * @return the request manager object.
     */
    public RequestManagerRestAssured init(final Context context) {
        this.context = context;
        this.reqSpec = context.getReqSpec();
        return this;
    }

    /**
     * Sets the parameters that'll be in the base request specification.
     *
     * @param params contains the parameter names and their values to send with the request.
     * @return the request manager object.
     */
    public RequestManagerRestAssured params(final Map<String, String> params) {
        reqSpec = given(reqSpec).params(mapOut(params));
        return this;
    }

    /**
     * Sets the query parameters that'll be in the base request specification.
     *
     * @param params contains the parameter names and their values to send with the request.
     * @return the request manager object.
     */
    public RequestManagerRestAssured queryParams(final Map<String, String> params) {
        reqSpec = given(reqSpec).queryParams(mapOut(params));
        return this;
    }

    /**
     * Sets the body that'll be in the base request specification.
     *
     * @param jsonData contains the string body to send.
     * @return the request manager object.
     */
    public RequestManagerRestAssured body(final String jsonData) {
        reqSpec = given(reqSpec).body(jsonData);
        return this;
    }

    /**
     * Sends a GET request to an <code>endpoint</code>.
     *
     * @param endpoint The path to send the request to.
     * @return The response of the request.
     */
    public Response get(final String endpoint) {
        return given(reqSpec).when().get(mapOut(endpoint));
    }

    /**
     * Sends a DELETE request to an <code>endpoint</code>.
     *
     * @param endpoint The path to send the request to.
     * @return The response of the request.
     */
    public Response delete(final String endpoint) {
        return given(reqSpec).when().delete(mapOut(endpoint));
    }

    /**
     * Sends a POST request to an <code>endpoint</code>.
     *
     * @param endpoint The path to send the request to.
     * @return The response of the request.
     */
    public Response post(final String endpoint) {
        return given(reqSpec).when().post(mapOut(endpoint));
    }

    /**
     * Sends a PUT request to an <code>endpoint</code>.
     *
     * @param endpoint The path to send the request to.
     * @return The response of the request.
     */
    public Response put(final String endpoint) {
        return given(reqSpec).when().put(mapOut(endpoint));
    }

    public static void displayFiltersData() {
        RestAssured.filters(new RequestLoggingFilter(), new ResponseLoggingFilter());
    }

    private String mapOut(final String endpoint) {
        return Mapper.replaceData(endpoint, context.getResponses());
    }

    private Map<String, String> mapOut(final Map<String, String> params) {
        return Mapper.replaceData(params, context.getResponses());
    }
}
