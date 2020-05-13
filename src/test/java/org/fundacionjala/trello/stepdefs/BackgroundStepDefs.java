package org.fundacionjala.trello.stepdefs;

import io.cucumber.java.en.When;
import org.fundacionjala.trello.entities.Board;

public class BackgroundStepDefs {

    private final Board board;

    public BackgroundStepDefs(final Board board) {
        this.board = board;
    }

    /**
     * Creates a new board.
     */
    @When("I have a board created")
    public void createBoard() {
        board.createNew();
    }
}
