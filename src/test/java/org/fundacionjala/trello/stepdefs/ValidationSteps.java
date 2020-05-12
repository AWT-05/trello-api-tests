package org.fundacionjala.trello.stepdefs;

import io.cucumber.java.en.Then;
import org.fundacionjala.trello.context.Context;
import org.fundacionjala.trello.utils.JsonSchemaUtils;
import org.fundacionjala.trello.utils.Mapper;

import java.util.Map;

import static org.testng.Assert.assertEquals;

/**
 * Groups of assertions step definitions.
 */
public class ValidationSteps {

    private static final String STATUS_CODE_ERROR_MESSAGE = "Expected status codeuser "
            + "does not match actual status code.";
    private static final String DATA_MATCH_ERROR_MSG = "The '%s' field does not match with expected value.";

    private final Context context;

    /**
     * Initializes an instance of AssertionsSteps class.
     *
     * @param context scenario context.
     */
    public ValidationSteps(final Context context) {
        this.context = context;
    }

    /**
     * Validates response status code.
     *
     * @param expectedStatusCode response status code.
     */
    @Then("I validate the response has status code {int}")
    public void iValidateTheResponseHasStatusCode(final int expectedStatusCode) {
        assertEquals(context.getResponse().getStatusCode(), expectedStatusCode, STATUS_CODE_ERROR_MESSAGE);
    }

    /**
     * Validates response body json schema.
     *
     * @param schemaPath json schema path.
     */
    @Then("I validate the response body should match with {string} JSON schema")
    public void iValidateTheResponseBodyShouldMatchWithJSONSchema(final String schemaPath) {
        JsonSchemaUtils.verifyJsonSchema(context.getResponse(), schemaPath);
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
            assertEquals(context.getResponse().jsonPath().getString(key), expectedData.get(key),
                    String.format(DATA_MATCH_ERROR_MSG, key));
        }
    }
}
