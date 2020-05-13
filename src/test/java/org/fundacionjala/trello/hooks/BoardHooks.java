package org.fundacionjala.trello.hooks;

import io.cucumber.java.After;
import org.fundacionjala.trello.client.IRequestManager;
import org.fundacionjala.trello.context.Context;

import static org.fundacionjala.trello.utils.Keys.BOARD;

public class BoardHooks {

    private static final int CLEAN_CONTEXT_ORDER_VALUE = 30;
    private Context context;
    private IRequestManager requestManager;

    /**
     * Initializes an instance of BoardHooks class.
     *
     * @param context scenario context object.
     * @param requestManager options to sending requests.
     */
    public BoardHooks(Context context, IRequestManager requestManager) {
        this.context = context;
        this.requestManager = requestManager;
    }

    /**
     * Delete boards saved in the context.
     */
    @After(value = "@deleteBoard", order = CLEAN_CONTEXT_ORDER_VALUE)
    public void cleanContextData() {
        context.getIdsByKey(BOARD.getValue())
                .forEach(id -> requestManager.init(context).delete("/boards/".concat(id)));
    }
}
