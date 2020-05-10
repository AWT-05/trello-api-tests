package org.fundacionjala.trello.config;

import io.cucumber.core.backend.ObjectFactory;
import io.cucumber.picocontainer.PicoFactory;

public class CucumberFactory implements ObjectFactory {

    private final PicoFactory delegate = new PicoFactory();

    public CucumberFactory() {
        System.setProperty("requestLibrary", "restassured");

        if (System.getProperty("requestLibrary") != null) {
            if ("restassured".equals(System.getProperty("requestLibrary").toLowerCase())) {
                addClass(RequestManagerRestAssured.class);
            } else {
                throw new RuntimeException("requestLibrary is not defined");
            }
        }
    }

    /**
     * Start the object factory.
     */
    @Override
    public void start() {
        delegate.start();
    }

    /**
     * Stops the object factory.
     */
    @Override
    public void stop() {
        delegate.stop();
    }

    /**
     * Add a glue class to the test context.
     *
     * @param glueClass class to add to the text context.
     * @return should always return true, should be ignored.
     */
    @Override
    public boolean addClass(final Class<?> glueClass) {
        return delegate.addClass(glueClass);
    }

    /**
     * Provides an instance of a glue class.
     *
     * @param glueClass type of instance to be created.
     * @param <T> type of Glue class.
     * @return new instance of type T.
     */
    @Override
    public <T> T getInstance(final Class<T> glueClass) {
        return delegate.getInstance(glueClass);
    }
}
