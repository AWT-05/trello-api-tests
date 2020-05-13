package org.fundacionjala.trello.entities;

import io.restassured.response.Response;
import org.fundacionjala.trello.client.IRequestManager;
import org.fundacionjala.trello.context.Context;
import static org.fundacionjala.trello.utils.Keys.BOARD;
import static org.fundacionjala.trello.utils.Keys.LIST;

import java.util.HashMap;
import java.util.Map;

public class List {
    private static final String ENDPOINT = "/lists";
    private static final String ID_KEY = "id";

    private Context context;
    private IRequestManager requestManager;

    public List(final Context context, final IRequestManager requestManager) {
        this.context = context;
        this.requestManager = requestManager;
    }

    /**
     * Creates a new list.
     */
    public void createNew() {
        createNew("Feature List Test", "top");
    }

    /**
     * Creates a new list with a given name.
     *
     * @param listName value name for the board.
     * @param position Valid values: top, bottom, positive integer.
     */
    public void createNew(final String listName, final String position) {
        String list = LIST.getValue();
        String idBoard = context.getIdsByKey(BOARD.getValue()).get(0);

        Map<String, String> body = new HashMap<>();
        body.put("name", listName);
        body.put("idBoard", idBoard);
        body.put("pos", position);

        Response response = requestManager.init(context).queryParams(body).post(ENDPOINT);
        context.saveResponse(list, response);
        String id = response.jsonPath().getString(ID_KEY);
        context.saveIds(list, id);
    }
}
