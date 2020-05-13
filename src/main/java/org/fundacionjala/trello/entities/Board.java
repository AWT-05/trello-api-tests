package org.fundacionjala.trello.entities;

import io.restassured.response.Response;
import org.fundacionjala.trello.config.IRequestManager;
import org.fundacionjala.trello.context.Context;

import java.util.HashMap;
import java.util.Map;

import static org.fundacionjala.trello.utils.Keys.BOARD;

public final class Board {
    private static final String ENDPOINT = "/boards";
    private static final String ID_KEY = "id";

    private Context context;
    private IRequestManager requestManager;

    public Board(final Context context, final IRequestManager requestManager) {
        this.context = context;
        this.requestManager = requestManager;
    }

    /**
     * Creates a new board with.
     */
    public void createNew() {
        createNew("My test board");
    }

    /**
     * Creates a new board with a given name.
     *
     * @param boardName value name for the board.
     */
    public void createNew(final String boardName) {
        String board = BOARD.getValue();
        Map<String, String> body = new HashMap<>();
        body.put("name", boardName);

        Response response = requestManager.init(context).params(body).post(ENDPOINT);
        context.saveResponse(board, response);
        String id = response.jsonPath().getString(ID_KEY);
        context.saveIds(board, id);
    }
}
