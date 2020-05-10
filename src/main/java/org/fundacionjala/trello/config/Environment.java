package org.fundacionjala.trello.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

/**
 * Reads environment properties.
 */
public class Environment {

    private static final Logger LOGGER = LoggerFactory.getLogger(Environment.class);
    private static final String FILTER_TAGS = "filterTags";
    private static final String BASE_URI = "baseUri";
    private static final String API_KEY = "apiKey";
    private static final String API_TOKEN = "apiToken";
    private static final String PROPERTIES_FILE_PATH = "gradle.properties";
    private Properties properties;

    /**
     * Configures the environment properties from gradle.properties.
     * Initializes instance of PropertiesUtils class.
     */

    private Environment() {
        try {
            FileInputStream fileInputStream = new FileInputStream(PROPERTIES_FILE_PATH);
            properties = new Properties();
            properties.load(fileInputStream);
        } catch (FileNotFoundException e) {
            String message = "Environment config file not found.";
            LOGGER.error(message);
            LOGGER.info(message, e);
            throw new RuntimeException(message, e);
        } catch (IOException e) {
            String message = "Input/Output exception, failed to load gradle.properties";
            LOGGER.error(message);
            LOGGER.info(message, e);
            throw new RuntimeException(message, e);
        }
    }

    /**
     * Gets string containing a specific environment property.
     *
     * @param env is the property name string.
     * @return the wanted property value.
     */
    private String getEnvProperty(final String env) {
        String property = System.getProperty(env);
        if (property == null) {
            return properties.getProperty(env);
        }
        return property;
    }

    /**
     * Gets filter tags property.
     *
     * @return filter tags property.
     */
    public String getFilterTags() {
        return getEnvProperty(FILTER_TAGS);
    }

    /**
     * Gets environment base URI.
     *
     * @return environment base URI.
     */
    public String getBaseUri() {
        return getEnvProperty(BASE_URI);
    }

    /**
     * Gets environment base URI.
     *
     * @return environment base URI.
     */
    public String getApiKey() {
        return getEnvProperty(API_KEY);
    }

    /**
     * Gets environment base URI.
     *
     * @return environment base URI.
     */
    public String getApiToken() {
        return getEnvProperty(API_TOKEN);
    }
}
