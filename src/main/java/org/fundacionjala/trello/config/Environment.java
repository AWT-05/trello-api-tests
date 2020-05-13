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
public final class Environment {

    private static final Logger LOGGER = LoggerFactory.getLogger(Environment.class);
    private static final String REQUEST_LIBRARY = "requestLibrary";
    private static final String FILTER_TAGS = "filterTags";
    private static final String BASE_URI = "baseUri";
    private static final String API_KEY = "apiKey";
    private static final String API_TOKEN = "apiToken";
    private static final String VERSION = "version";
    private static final String THREAD_COUNT = "cucumberThreadCount";
    private static final String PROPERTIES_FILE_PATH = "gradle.properties";
    private static Environment instance;
    private Properties properties;

    /**
     * Configures the environment properties from gradle.properties.
     * Initializes an instance of PropertiesUtils class.
     */
    private Environment() {
        try (FileInputStream fileInputStream = new FileInputStream(PROPERTIES_FILE_PATH)) {
            properties = new Properties();
            properties.load(fileInputStream);
        } catch (FileNotFoundException e) {
            String message = "Environment config file not found.";
            LOGGER.error(message);
            LOGGER.info(message, e);
        } catch (IOException e) {
            String message = "Input/Output exception, failed to load gradle.properties";
            LOGGER.error(message);
            LOGGER.info(message, e);
        }
    }

    /**
     * Gets singleton instance of the Environment class.
     *
     * @return Environment instance.
     */
    public static Environment getInstance() {
        if (instance == null) {
            instance = new Environment();
        }
        return instance;
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
     * Gets request library name.
     *
     * @return filter requestLibrary property.
     */
    public String getRequestLibrary() {
        return getEnvProperty(REQUEST_LIBRARY);
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
        String baseUri = getEnvProperty(BASE_URI);
        String version = getEnvProperty(VERSION);
        return baseUri.concat(version);
    }

    /**
     * Gets environment API Key.
     *
     * @return environment API Key.
     */
    public String getApiKey() {
        return getEnvProperty(API_KEY);
    }

    /**
     * Gets environment API Token.
     *
     * @return environment API Token.
     */
    public String getApiToken() {
        return getEnvProperty(API_TOKEN);
    }

    /**
     * Gets environment Version.
     *
     * @return environment Version.
     */
    public String getVersion() {
        return getEnvProperty(VERSION);
    }

    /**
     * Gets environment Thread Count.
     *
     * @return environment API Token.
     */
    public String getThreadCount() {
        return getEnvProperty(THREAD_COUNT);
    }
}
