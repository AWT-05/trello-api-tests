package org.fundacionjala.trello.context;

import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Repository class to store and share data among step definitions.
 */
public class Context {

    private RequestSpecification reqSpec;
    private Map<String, Response> responses;
    private Map<String, List<String>> mapIds;
    private Response response;

    /**
     * Initializes an instance of Context class.
     */
    public Context() {
        initializeValues();
    }

    /**
     * Initializes context values.
     */
    public void initializeValues() {
        reqSpec = null;
        responses = new HashMap<>();
        mapIds = new HashMap<>();
    }

    /**
     * Sets request specification.
     *
     * @param reqSpec request specification.
     */
    public void setReqSpec(final RequestSpecification reqSpec) {
        this.reqSpec = reqSpec;
    }

    /**
     * Gets request specification.
     *
     * @return request specification.
     */
    public RequestSpecification getReqSpec() {
        return reqSpec;
    }

    /**
     * Saves response according to key.
     *
     * @param key      key identifier.
     * @param response response object.
     */
    public void saveResponse(final String key, final Response response) {
        responses.put(key, response);
    }

    /**
     * Gets context responses.
     *
     * @return context responses.
     */
    public Map<String, Response> getResponses() {
        return responses;
    }

    /**
     * Saves id in a map.
     *
     * @param key map key.
     * @param id  project id.
     */
    public void saveIds(final String key, final String id) {
        if (!mapIds.containsKey(key)) {
            mapIds.put(key, new ArrayList<>());
        }
        mapIds.get(key).add(id);
    }

    /**
     * Gets saved map by key.
     *
     * @param key map key.
     * @return id values.
     */
    public List<String> getIdsByKey(final String key) {
        return mapIds.getOrDefault(key, new ArrayList<>());
    }


    /**
     * Saves the response.
     *
     * @param response response.
     */
    public void setResponse(final Response response) {
        this.response = response;
    }

    /**
     * Gets the context response.
     *
     * @return response value.
     */
    public Response getResponse() {
        return response;
    }
}
