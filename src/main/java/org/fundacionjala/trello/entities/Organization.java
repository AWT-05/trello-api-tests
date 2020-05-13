package org.fundacionjala.trello.entities;

import io.restassured.response.Response;
import org.fundacionjala.trello.client.IRequestManager;
import org.fundacionjala.trello.context.Context;

import java.util.HashMap;
import java.util.Map;

import static org.fundacionjala.trello.utils.Keys.ORGANIZATION;

public class Organization {

    private static final String ENDPOINT = "/organizations";
    private static final String JSON_PATH_STRING_ID = "id";
    private static final String ORGANIZATION_DISPLAY_NAME = "displayName";
    private static final String ORGANIZATION_UNIQUE_NAME = "name";
    private Context context;
    private IRequestManager requestManager;

    public Organization(final Context context, final IRequestManager requestManager) {
        this.context = context;
        this.requestManager = requestManager;
    }

    /**
     * Creates a new organization.
     */
    public void createNew() {
        createNew("New organization test", "new_org_unique_name23");
    }

    /**
     * Creates a new organization with a given name.
     *
     * @param orgDisplayName value name of the organization.
     * @param orgName        unique value name of the organization.
     */
    public void createNew(final String orgDisplayName, final String orgName) {
        String org = ORGANIZATION.getValue();
        Map<String, String> orgParams = new HashMap<>();
        orgParams.put(ORGANIZATION_DISPLAY_NAME, orgDisplayName);
        orgParams.put(ORGANIZATION_UNIQUE_NAME, orgName);

        Response response = requestManager.init(context).queryParams(orgParams).post(ENDPOINT);
        context.saveResponse(org, response);
        context.saveIds(org, response.jsonPath().getString(JSON_PATH_STRING_ID));
    }
}
