package org.fundacionjala.trello.stepdefs;

import io.cucumber.java.en.And;
import org.fundacionjala.trello.client.Organization;
import org.fundacionjala.trello.client.TestObject;

import java.util.HashMap;
import java.util.Map;

public class BackgroundStepDefs {

    Organization org;

    public BackgroundStepDefs(Organization org) {
        this.org = org;
    }

    @And("I have an organization created")
    public void iHaveAnCreated() {
        org.createNew();
        org.createNew("The best team");
    }
}
