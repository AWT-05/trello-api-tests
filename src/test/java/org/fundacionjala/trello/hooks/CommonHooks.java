package org.fundacionjala.trello.hooks;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import org.fundacionjala.trello.client.RequestManagerRestAssured;
import org.fundacionjala.trello.context.Context;
import org.fundacionjala.trello.utils.RequestSpecUtils;

/**
 * Groups common preconditions and post conditions methods.
 */
public class CommonHooks {

    private static final int CLEAN_CONTEXT_ORDER_VALUE = 0;
    private static final int BUILD_REQ_SEC_ORDER_VALUE = 0;

    private Context context;

    /**
     * Initializes an instance of CommonHooks class.
     *
     * @param context scenario context object.
     */
    public CommonHooks(final Context context) {
        this.context = context;
    }

    /**
     * Builds default request specification without authentication header.
     */
    @Before(order = BUILD_REQ_SEC_ORDER_VALUE)
    public void buildDefaultReqSpec() {
//        RequestManagerRestAssured.displayFiltersData(); // Only for help
        context.setReqSpec(RequestSpecUtils.build());
    }

    /**
     * Cleans context values.
     */
    @After(order = CLEAN_CONTEXT_ORDER_VALUE)
    public void cleanContextData() {
        context.initializeValues();
    }
}
