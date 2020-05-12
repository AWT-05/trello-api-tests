package org.fundacionjala.trello.entities;

import io.restassured.response.Response;
import org.fundacionjala.trello.client.IRequestManager;
import org.fundacionjala.trello.context.Context;

import java.util.HashMap;
import java.util.Map;

public class Organization {

    private final String endpoint = "/organizations";

    private Context context;
    private IRequestManager requestManager;
    private Response response;

    public Organization(final Context context, final IRequestManager requestManager) {
        this.context = context;
        this.requestManager = requestManager;
    }

    /**
     * Creates a new organization.
     *
     * @param key a string to save the response
     */
    public void createNew(final String key) {
        createNew(key, "API Test team");
    }

    /**
     * Creates a new organization with a given name.
     *
     * @param key a string to save the response
     * @param displayName value name of the organization.
     */
    public void createNew(final String key, final String displayName) {
        Map<String, String> orgParams = new HashMap<>() {{
            put("displayName", displayName);
        }};

        response = requestManager.init(context).queryParams(orgParams).post(endpoint);
        context.saveResponse(key, response);
    }
}
