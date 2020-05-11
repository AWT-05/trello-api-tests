package org.fundacionjala.trello.stepdefs;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import org.fundacionjala.trello.config.IRequestManager;

import java.util.Map;

/**
 * Groups request step definitions.
 */
public class RequestSteps {

    private Response response;

    private final IRequestManager requestManager;

    /**
     * Initializes an instance of RequestSteps class.
     *
     * @param requestManager helper to sending requests.
     */
    public RequestSteps(final IRequestManager requestManager) {
        this.requestManager = requestManager;
    }

    /**
     * Sets authentication header to base request specification.
     */
    @Given("I set authentication using API key and token")
    public void setAuthenticationToken() {
        requestManager.authenticate();
    }

    /**
     * Sets base request specification without authentication.
     */
    @Given("I don't set authentication")
    public void withoutAuthenticationToken() {
        requestManager.noAuthenticate();
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
