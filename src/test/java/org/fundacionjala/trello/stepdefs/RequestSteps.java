package org.fundacionjala.trello.stepdefs;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.trello.config.IRequestManager;
import org.fundacionjala.trello.context.Context;
import org.fundacionjala.trello.utils.RequestSpecUtils;

import java.util.Map;

/**
 * Groups request step definitions.
 */
public class RequestSteps {

    private final Context context;
    private Response response;

    private final IRequestManager requestManager;

    /**
     * Initializes an instance of RequestSteps class.
     *
     * @param requestManager helper to sending requests.
     */
    public RequestSteps(final Context context, final IRequestManager requestManager) {
        this.context = context;
        this.requestManager = requestManager;
    }

    /**
     * Sets authentication header to base request specification.
     */
    @Given("I set authentication using API key and token")
    public void setAuthenticationToken() {
        RequestSpecification reqSpec = RequestSpecUtils.buildWithAuth();
        context.setReqSpec(reqSpec);
    }

    /**
     * Sets base request specification without authentication.
     */
    @Given("I don't set authentication")
    public void withoutAuthenticationToken() {
        RequestSpecification reqSpec = RequestSpecUtils.build();
        context.setReqSpec(reqSpec);
    }

    /**
     * Sends GET request.
     *
     * @param endpoint resource endpoint.
     */
    @When("I send a GET request to {string}")
    public void sendGETRequestWithParameters(final String endpoint) {
        response = requestManager.init(context).get(endpoint);
    }

    /**
     * Sends DELETE request.
     *
     * @param endpoint resource endpoint.
     */
    @When("I send a DELETE request to {string}")
    public void sendDELETERequestWithParameters(final String endpoint) {
        response = requestManager.init(context).delete(endpoint);
    }

    /**
     * Sends POST request with parameters.
     *
     * @param endpoint resource endpoint.
     * @param params   request parameters.
     */
    @When("I send a POST request to {string} with the following parameters")
    public void sendPOSTRequestWithParameters(final String endpoint, final Map<String, String> params) {
        response = requestManager.init(context).queryParams(params).post(endpoint);
    }

    /**
     * Sends PUT request with parameters.
     *
     * @param endpoint resource endpoint.
     * @param params   request parameters.
     */
    @When("I send a PUT request to {string} with the following parameters")
    public void sendPUTRequestWithParameters(final String endpoint, final Map<String, String> params) {
        response = requestManager.init(context).queryParams(params).put(endpoint);
    }

    @And("I save the response as {string}")
    public void iSaveTheResponseAs(String responseKey) {
        context.saveResponse(responseKey, response);
    }
}
