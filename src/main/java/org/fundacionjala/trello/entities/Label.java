package org.fundacionjala.trello.entities;

import io.restassured.response.Response;
import org.fundacionjala.trello.client.IRequestManager;
import org.fundacionjala.trello.context.Context;

import java.util.HashMap;
import java.util.Map;

import static org.fundacionjala.trello.utils.Keys.BOARD;
import static org.fundacionjala.trello.utils.Keys.LABEL;

public final class Label {
    private static final String ENDPOINT = "/labels";
    private static final String ID_KEY = "id";

    private Context context;
    private IRequestManager requestManager;

    public Label(final Context context, final IRequestManager requestManager) {
        this.context = context;
        this.requestManager = requestManager;
    }

    /**
     * Creates a new label with.
     */
    public void createNew() {
        createNew("feature test", "sky");
    }

    /**
     * Creates a new label with a given name.
     *
     * @param labelName value name for the board.
     */
    public void createNew(final String labelName, String color) {
        String label = LABEL.getValue();
        String idBoard = context.getIdsByKey(BOARD.getValue()).get(0);

        Map<String, String> body = new HashMap<>();
        body.put("idBoard", idBoard);
        body.put("name", labelName);
        body.put("color", color);

        Response response = requestManager.init(context).queryParams(body).post(ENDPOINT);
        context.saveResponse(label, response);
        String id = response.jsonPath().getString(ID_KEY);
        context.saveIds(label, id);
    }
}
