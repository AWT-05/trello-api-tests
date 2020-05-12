package org.fundacionjala.trello.stepdefs;

import io.cucumber.java.en.When;
import org.fundacionjala.trello.client.Organization;
import org.fundacionjala.trello.context.Context;

public class BackgroundStepDefs {

    private Context context;
    private Organization org;

    public BackgroundStepDefs(final Context context, final Organization org) {
        this.context = context;
        this.org = org;
    }

    /**
     * Create a organization by default.
     *
     * @param responseKey a string to save the response
     */
    @When("I have an organization created as {string}")
    public void haveAnOrgCreated(final String responseKey) {
        org.createNew(responseKey);
    }
}
