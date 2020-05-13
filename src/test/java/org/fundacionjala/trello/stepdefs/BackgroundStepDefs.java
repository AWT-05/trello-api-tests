package org.fundacionjala.trello.stepdefs;

import io.cucumber.java.en.When;
import org.fundacionjala.trello.entities.Board;
import org.fundacionjala.trello.entities.Organization;
import org.fundacionjala.trello.context.Context;

public class BackgroundStepDefs {

    private Context context;
    private Organization org;
    private Board board;

    public BackgroundStepDefs(final Context context, final Organization org, final Board board) {
        this.context = context;
        this.org = org;
        this.board = board;
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

    /**
     * Creates a new board by default.
     */
    @When("I have a board created")
    public void createBoard() {
        board.createNew();
    }
}
