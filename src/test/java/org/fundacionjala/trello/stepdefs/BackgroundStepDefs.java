package org.fundacionjala.trello.stepdefs;

import io.cucumber.java.en.When;
import org.fundacionjala.trello.context.Context;
import org.fundacionjala.trello.entities.Board;
import org.fundacionjala.trello.entities.Label;
import org.fundacionjala.trello.entities.Organization;

public class BackgroundStepDefs {

    private Context context;
    private Organization org;
    private Board board;
    private Label label;

    public BackgroundStepDefs(final Context context, final Organization org, final Board board, final Label label) {
        this.context = context;
        this.org = org;
        this.board = board;
        this.label = label;
    }

    /**
     * Creates an organization by default.
     *
     */
    @When("I have an organization created")
    public void haveAnOrgCreated() {
        org.createNew();
    }

    /**
     * Creates a new board by default.
     */
    @When("I have a board created")
    public void createBoard() {
        board.createNew();
    }

    /**
     * Creates a new label by default.
     */
    @When("I have a label created")
    public void iHaveALabelCreated() {
        label.createNew();
    }
}
