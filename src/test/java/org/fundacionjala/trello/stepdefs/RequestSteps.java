package org.fundacionjala.trello.stepdefs;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.trello.client.IRequestManager;
import org.fundacionjala.trello.context.Context;
import org.fundacionjala.trello.utils.JsonSchemaUtils;
import org.fundacionjala.trello.utils.Mapper;
import org.fundacionjala.trello.utils.RequestSpecUtils;

import java.util.Map;

import static org.testng.Assert.assertEquals;

/**
 * Groups request step definitions.
 */
public class RequestSteps {

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
     * Validates response status code.
     *
     * @param expectedStatusCode response status code.
     */
    @Then("I validate the response has status code {int}")
    public void iValidateTheResponseHasStatusCode(final int expectedStatusCode) {
        assertEquals(response.getStatusCode(), expectedStatusCode, STATUS_CODE_ERROR_MESSAGE);
    }

    /**
     * Validates response body json schema.
     *
     * @param schemaPath json schema path.
     */
    @Then("I validate the response body should match with {string} JSON schema")
    public void iValidateTheResponseBodyShouldMatchWithJSONSchema(final String schemaPath) {
        JsonSchemaUtils.verifyJsonSchema(response, schemaPath);
    }

    /**
     * Validates that response contains expected data.
     *
     * @param data expected data.
     */
    @Then("I validate the response contains the following data")
    public void iValidateTheResponseContainsTheFollowingData(final Map<String, String> data) {
        Map<String, String> expectedData = Mapper.replaceData(data, context.getResponses());
        for (String key : data.keySet()) {
            assertEquals(response.jsonPath().getString(key), expectedData.get(key),
                    String.format(DATA_MATCH_ERROR_MSG, key));
        }
    }
}
