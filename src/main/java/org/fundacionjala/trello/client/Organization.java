package org.fundacionjala.trello.client;

import io.restassured.response.Response;
import org.fundacionjala.trello.config.IRequestManager;
import org.fundacionjala.trello.context.Context;

import java.util.HashMap;
import java.util.Map;

public class Organization extends TestObject {

    private final String ORG_KEY = "org";
    private final String ENDPOINT = "/organizations";

    private Context context;
    IRequestManager requestManager;
    private Response response;

    public Organization(Context context, IRequestManager requestManager) {
        this.context = context;
        this.requestManager = requestManager;
    }

    /**
     * Creates a new organization.
     */
    public void createNew() {
        createNew("API Test team");
    }

    /**
     * Creates a new organization with a given name.
     *
     * @param displayName value name of the organization.
     */
    public void createNew(final String displayName) {
        Map<String, String> orgParams = new HashMap<>() {{
            put("displayName", displayName);
        }};

        //requestManager.fresh().params(orgParams).post(ENDPOINT);
        response = requestManager.queryParams(orgParams).post(ENDPOINT);

        context.saveResponse(ORG_KEY, response);
    }
}
