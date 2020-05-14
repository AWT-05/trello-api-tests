@deleteBoard
Feature: Board Controller

  Background: Set the authentication
    Given I set authentication using API key and token

  @functional
  Scenario: Create a board with just basic required parameter
    When I send a POST request to "/boards" with the following parameters
      | name | Hello New Board! |
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name | Hello New Board! |

  @Smoke
  Scenario: Create a board with optional parameters
    When I send a POST request to "/boards" with the following parameters
      | name             | Hello New Board!                                   |
      | desc             | This is the description for the new board created. |
      | prefs_background | green                                              |
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Hello New Board!                                   |
      | desc             | This is the description for the new board created. |
      | prefs.background | green                                              |

  @functional
  Scenario Outline: Create a board with description parameter with special chars
    When I send a POST request to "/boards" with the following parameters
      | name             | Hello New Board! |
      | desc             | <value>          |
      | prefs_background | green            |
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Hello New Board! |
      | desc             | <description>    |
      | prefs.background | green            |
    Examples:
      | value              | description        |
      | $%&$%&$%&$%& 4$%&  | $%&$%&$%&$%& 4$%&  |
      | bbbbbbbbbbbbbbbbbb | bbbbbbbbbbbbbbbbbb |
      | 99999999999999999  | 99999999999999999  |
      | abcdef12.0abcdeffF | abcdef12.0abcdeffF |
      | {empty}            | {empty}            |

  @functional
  Scenario Outline: Create a board with different background colors
    When I send a POST request to "/boards" with the following parameters
      | name             | Hello New Board!                                   |
      | desc             | This is the description for the new board created. |
      | prefs_background | <value>                                            |
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Hello New Board!                                   |
      | desc             | This is the description for the new board created. |
      | prefs.background | <color>                                            |
    Examples:
      | value  | color  |
      | green  | green  |
      | blue   | blue   |
      | pink   | pink   |
      | purple | purple |
      | lime   | lime   |
      | sky    | sky    |
      | red    | red    |
      | grey   | grey   |

  @negative
  Scenario: Create a board with invalid required parameter
    When I send a POST request to "/boards" with the following parameters
      | nameSSSSS | Hello New Board! |
    Then I validate the response has status code 400

  @negative
  Scenario: Create a board with invalid required parameter
    When I send a POST request to "/boards" with the following parameters
      | name | {empty} |
    Then I validate the response has status code 400

  @negative
  Scenario Outline: Create a board with basic required parameter with special chars
    When I send a POST request to "/boards" with the following parameters
      | name | <value> |
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name | <name> |
    Examples:
      | value              | name               |
      | $%&$%&$%&$%& 4$%&  | $%&$%&$%&$%& 4$%&  |
      | bbbbbbbbbbbbbbbbbb | bbbbbbbbbbbbbbbbbb |
      | 99999999999999999  | 99999999999999999  |
      | abcdef12.0abcdeffF | abcdef12.0abcdeffF |
