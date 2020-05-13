package org.fundacionjala.trello.stepdefs;

import io.cucumber.java.en.Then;
import org.fundacionjala.trello.context.Context;
import org.fundacionjala.trello.utils.JsonSchemaUtils;

import java.util.Map;

import static org.testng.Assert.assertEquals;

/**
 * Groups of validation steps definitions.
 */
public class ValidationSteps {

    private static final String STATUS_CODE_ERROR_MESSAGE = "Expected status codeuser "
            + "does not match actual status code.";
    private static final String NO_EQUALS_ERROR_MESSAGE = "Expected value does not match actual value.";

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
        JsonSchemaUtils.verifyResponseData(context.getResponse(), context.getResponses(), data);
    }

    @Then("I validate the response contains the following value")
    public void validateResponseContains(final String content) {
        String actualContent = context.getResponse().body().asString()
                .replace(" ", "");
        assertEquals(actualContent, content, NO_EQUALS_ERROR_MESSAGE);
    }

    @Then("I validate the response contains the following json")
    public void iValidateTheResponseContainsTheFollowingJson(final String content) {
        String expectedContent = content
                .replace("\n", "")
                .replace("\r", "")
                .replace(" ", "");
        validateResponseContains(expectedContent);
    }
}
