package org.fundacionjala.trello.hooks;

import io.cucumber.java.After;
import org.fundacionjala.trello.client.IRequestManager;
import org.fundacionjala.trello.context.Context;
import static org.fundacionjala.trello.utils.Keys.LIST;

public class ListHooks {

    private static final int CLEAN_CONTEXT_ORDER_VALUE = 40;
    private Context context;
    private IRequestManager requestManager;

    /**
     * Initializes an instance of LabelHooks class.
     *
     * @param context scenario context object.
     * @param requestManager options to sending requests.
     */
    public ListHooks(final Context context, final IRequestManager requestManager) {
        this.context = context;
        this.requestManager = requestManager;
    }

    /**
     * Delete labels saved in the context.
     */
    @After(value = "@archiveList", order = CLEAN_CONTEXT_ORDER_VALUE)
    public void cleanContextData() {
        context.getIdsByKey(LIST.getValue())
                .forEach(id -> requestManager.init(context).put("/lists/".concat(id).concat("/closed")));
    }
}
