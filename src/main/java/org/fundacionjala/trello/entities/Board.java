package org.fundacionjala.trello.entities;

import io.restassured.response.Response;
import org.fundacionjala.trello.client.IRequestManager;
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
        createNew("New test board", "The board's description", "orange");
    }

    /**
     * Creates a new board with a given name, description and background.
     *
     * @param boardName            value name for the board.
     * @param boardDesc            value description for the board.
     * @param boardPrefsBackground value color of background for the board.
     */
    public void createNew(final String boardName, final String boardDesc, final String boardPrefsBackground) {
        String board = BOARD.getValue();
        Map<String, String> body = new HashMap<>();
        body.put("name", boardName);
        body.put("desc", boardDesc);
        body.put("prefs_background", boardPrefsBackground);

        Response response = requestManager.init(context).queryParams(body).post(ENDPOINT);
        context.saveResponse(board, response);
        String id = response.jsonPath().getString(ID_KEY);
        context.saveIds(board, id);
    }
}
