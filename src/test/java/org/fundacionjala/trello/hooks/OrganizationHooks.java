package org.fundacionjala.trello.hooks;

import io.cucumber.java.After;
import io.restassured.response.Response;
import org.fundacionjala.trello.config.IRequestManager;
import org.fundacionjala.trello.context.Context;

public class OrganizationHooks {

    private static final  int CLEAN_CONTEXT_ORDER_VALUE = 20;
    private final Context context;
    private Response response;
    private final IRequestManager requestManager;

    /**
     * Initializes an instance of OrganizationHooks class.
     *
     * @param context scenario context object.
     * @param requestManager to send request.
     */
    public OrganizationHooks(Context context, IRequestManager requestManager) {
        this.context = context;
        this.requestManager = requestManager;
    }

    /**
     * Delete organizations
     */
    @After(value = "@deleteOrganization", order = CLEAN_CONTEXT_ORDER_VALUE)
    public void cleanOrganizationsData(){
        context.getIdsByKey("organizationId").
                forEach(id -> response = requestManager.init(context).delete("/organizations/".concat(id)));
    }
}
