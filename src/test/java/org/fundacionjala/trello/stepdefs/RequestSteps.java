package org.fundacionjala.trello.stepdefs;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import org.fundacionjala.trello.config.IRequestManager;
import org.fundacionjala.trello.context.Context;

import java.util.Map;

/**
 * Groups request step definitions.
 */
public class RequestSteps {

    private static final String SCHEMAS_BASE_FOLDER = "src/test/resources/schemas/";
    private static final String STATUS_CODE_ERROR_MESSAGE = "Expected status codeuser "
            + "does not match actual status code.";
    private static final String DATA_MATCH_ERROR_MSG = "The '%s' field does not match with expected value.";

    private final Context context;
    private Response response;
    private final IRequestManager requestManager;

    /**
     * Initializes an instance of RequestSteps class.
     *
     * @param context        scenario context.
     * @param requestManager helper to sending requests.
     */
    public RequestSteps(final Context context, final IRequestManager requestManager) {
        this.context = context;
        this.requestManager = requestManager;
    }

    /**
     * Sets authentication header to base request specification.
     *
     * @param username account username.
     */
    @Given("I set authentication token using {string} account")
    public void setAuthenticationToken(final String username) {
        requestManager.withAuthentication(username);
    }

    /**
     * Sets base request specification without authentication.
     */
    @When("I don't set authentication token")
    public void withoutAuthenticationToken() {
        requestManager.withoutAuthentication();
    }

    /**
     * Sends GET request.
     *
     * @param endpoint resource endpoint.
     */
    @When("I send a GET request to {string}")
    public void sendGETRequestWithParameters(final String endpoint) {
        response = requestManager.get(endpoint);
    }

    /**
     * Sends DELETE request.
     *
     * @param endpoint resource endpoint.
     */
    @When("I send a DELETE request to {string}")
    public void sendDELETERequestWithParameters(final String endpoint) {
        response = requestManager.delete(endpoint);
    }

    /**
     * Sends POST request with parameters.
     *
     * @param endpoint resource endpoint.
     * @param params   request parameters.
     */
    @When("I send a POST request to {string} with the following parameters")
    public void sendPOSTRequestWithParameters(final String endpoint, final Map<String, String> params) {
        response = requestManager.params(params).post(endpoint);
    }

    /**
     * Sends PUT request with parameters.
     *
     * @param endpoint resource endpoint.
     * @param params   request parameters.
     */
    @When("I send a PUT request to {string} with the following parameters")
    public void sendPUTRequestWithParameters(final String endpoint, final Map<String, String> params) {
        response = requestManager.params(params).put(endpoint);
    }
}
