package org.fundacionjala.trello.utils;

import io.restassured.response.Response;

import java.io.File;

import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchema;

/**
 * Groups utility methods to use Json Schema validations.
 */
public final class JsonSchemaUtils {

    private static final String SCHEMAS_BASE_FOLDER = "src/test/resources/schemas/";

    private JsonSchemaUtils() {
    }

    /**
     * Verify the responses of json schema.
     *
     * @param response   response.
     * @param schemaPath json schema path.
     */
    public static void verifyJsonSchema(final Response response, final String schemaPath) {
        File schemaFile = new File(SCHEMAS_BASE_FOLDER.concat(schemaPath));
        response.then().assertThat().body(matchesJsonSchema(schemaFile));
    }
}
