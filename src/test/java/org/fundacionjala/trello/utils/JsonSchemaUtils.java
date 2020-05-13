package org.fundacionjala.trello.utils;

import io.restassured.response.Response;

import java.io.File;
import java.util.Map;

import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchema;
import static org.testng.Assert.assertEquals;

/**
 * Groups utility methods to use Json Schema validations.
 */
public final class JsonSchemaUtils {

    private static final String SCHEMAS_BASE_FOLDER = "src/test/resources/schemas/";
    private static final String DATA_MATCH_ERROR_MSG = "The '%s' field does not match with expected value.";

    private JsonSchemaUtils() {
    }

    /**
     * Verify the responses of json schema.
     *
     * @param response   response from commons steps.
     * @param schemaPath json schema path.
     */
    public static void verifyJsonSchema(final Response response, final String schemaPath) {
        File schemaFile = new File(SCHEMAS_BASE_FOLDER.concat(schemaPath));
        response.then().assertThat().body(matchesJsonSchema(schemaFile));
    }

    /**
     * Verify the data table.
     *
     * @param response  response from commons steps.
     * @param responses map of responses.
     * @param data      map of data table.
     */
    public static void verifyResponseData(final Response response, final Map<String, Response> responses,
                                          final Map<String, String> data) {
        Map<String, String> expectedData = Mapper.replaceData(data, responses);
        for (String key : data.keySet()) {
            assertEquals(response.jsonPath().getString(key), expectedData.get(key),
                    String.format(DATA_MATCH_ERROR_MSG, key));
        }
    }
}
