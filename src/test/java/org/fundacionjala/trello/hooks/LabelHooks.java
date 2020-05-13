package org.fundacionjala.trello.hooks;

import io.cucumber.java.After;
import org.fundacionjala.trello.client.IRequestManager;
import org.fundacionjala.trello.context.Context;

import static org.fundacionjala.trello.utils.Keys.LABEL;

public class LabelHooks {

    private static final int CLEAN_CONTEXT_ORDER_VALUE = 50;
    private Context context;
    private IRequestManager requestManager;

    /**
     * Initializes an instance of LabelHooks class.
     *
     * @param context scenario context object.
     * @param requestManager options to sending requests.
     */
    public LabelHooks(Context context, IRequestManager requestManager) {
        this.context = context;
        this.requestManager = requestManager;
    }

    /**
     * Delete labels saved in the context.
     */
    @After(value = "@deleteLabel", order = CLEAN_CONTEXT_ORDER_VALUE)
    public void cleanContextData() {
        context.getIdsByKey(LABEL.getValue())
                .forEach(id -> requestManager.init(context).delete("/labels/".concat(id)));
    }
}
