package org.fundacionjala.trello.stepdefs;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.trello.client.IRequestManager;
import org.fundacionjala.trello.context.Context;
import org.fundacionjala.trello.utils.RequestSpecUtils;

import java.util.Map;

/**
 * Groups request step definitions.
 */
public class RequestSteps {

    private static final String JSON_PATH_STRING_ID = "id";
    private final Context context;
    private final IRequestManager requestManager;
    private Response response;

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
     */
    @Given("I set authentication using API key and token")
    public void setAuthentication() {
        RequestSpecification reqSpec = RequestSpecUtils.buildWithAuth();
        context.setReqSpec(reqSpec);
    }

    /**
     * Sets authentication only with API key.
     */
    @Given("I set authentication using only an API key")
    public void setAuthenticationAPIKey() {
        RequestSpecification reqSpec = RequestSpecUtils.buildOnlyApiKey();
        context.setReqSpec(reqSpec);
    }

    /**
     * Sets authentication only with API key.
     */
    @Given("I set authentication using only a Token")
    public void setAuthenticationToken() {
        RequestSpecification reqSpec = RequestSpecUtils.buildOnlyToken();
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
        context.setResponse(response);
    }

    /**
     * Sends GET request with parameters.
     *
     * @param endpoint resource endpoint.
     * @param params   request parameters.
     */
    @When("I send a GET request to {string} with the following parameters")
    public void iSendAGETRequestToWithTheFollowingParameters(final String endpoint, final Map<String, String> params) {
        response = requestManager.init(context).queryParams(params).get(endpoint);
        context.setResponse(response);
    }

    /**
     * Sends DELETE request.
     *
     * @param endpoint resource endpoint.
     */
    @When("I send a DELETE request to {string}")
    public void sendDELETERequestWithParameters(final String endpoint) {
        response = requestManager.init(context).delete(endpoint);
        context.setResponse(response);
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
        context.setResponse(response);
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
        context.setResponse(response);
    }

    /**
     * Saves response to context.
     *
     * @param responseKey key identifier.
     */
    @When("I save response as {string}")
    public void iSaveResponseAs(final String responseKey) {
        context.saveResponse(responseKey, response);
    }

    /**
     * Saves the instance id in the context..
     *
     * @param key expected data.
     */
    @When("I save the id value to clean {string} workspace")
    public void saveTheValueToCleanWorkspace(final String key) {
        context.saveIds(key, response.jsonPath().getString(JSON_PATH_STRING_ID));
    }

    /**
     * Sends POST request with json body.
     *
     * @param endpoint resource endpoint.
     * @param body     request json body.
     */
    @When("I send a POST request to {string} with the following json body")
    public void sendPOSTRequestWithJsonBody(final String endpoint, final String body) {
        response = requestManager.init(context).body(body).post(endpoint);
        context.setResponse(response);
    }

    /**
     * Sends PUT request with json body.
     *
     * @param endpoint resource endpoint.
     * @param body     request json body.
     */
    @When("I send a PUT request to {string} with the following json body")
    public void sendPUTRequestWithJsonBody(final String endpoint, final String body) {
        response = requestManager.init(context).body(body).put(endpoint);
        context.setResponse(response);
    }

    /**
     * Sends GET request with json body.
     *
     * @param endpoint resource endpoint.
     * @param body     request json body.
     */
    @When("I send a GET request to {string} with the following json body")
    public void iSendAGETRequestToWithTheFollowingJsonBody(final String endpoint, final String body) {
        response = requestManager.init(context).body(body).get(endpoint);
        context.setResponse(response);
    }
}
