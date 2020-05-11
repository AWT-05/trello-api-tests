package org.fundacionjala.trello.utils;


import io.restassured.response.Response;

import java.util.Map;

/**
 * Gropus utility methods to map data.
 */
public final class Mapper {

    /**
     * Private constructor for Mapper utility class.
     */
    private Mapper() {

    }

    /**
     * Replaces data according to pattern.
     *
     * @param content   original content.
     * @param responses response objects stored.
     * @return string mapped.
     */
    public static String replaceData(final String content, final Map<String, Response> responses) {
        // To do.
        return content;
    }

    /**
     * Replaces data in map according to pattern.
     *
     * @param content   original content.
     * @param responses response objects stored.
     * @return mapped data.
     */
    public static Map<String, String> replaceData(final Map<String, String> content,
                                                  final Map<String, Response> responses) {
        // To do.
        return content;
    }
}
