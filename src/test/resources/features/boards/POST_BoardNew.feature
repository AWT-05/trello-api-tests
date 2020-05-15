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

  @smoke
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
  Scenario: Create a board with description parameter with special chars
    When I send a POST request to "/boards" with the following parameters
      | name             | Hello New Board!          |
      | desc             | 5ebcf20b25ab832271a56fb%$ |
      | prefs_background | green                     |
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Hello New Board!          |
      | desc             | 5ebcf20b25ab832271a56fb%$ |
      | prefs.background | green                     |

  @functional
  Scenario: Create a board with empty description parameter
    When I send a POST request to "/boards" with the following parameters
      | name             | Hello New Board! |
      | desc             | {empty}          |
      | prefs_background | green            |
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Hello New Board! |
      | desc             | {empty}          |
      | prefs.background | green            |

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
  Scenario: Create a board with empty required parameter
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
      | value                     | name                      |
      | 5ebcf20b25ab832271a56fb%$ | 5ebcf20b25ab832271a56fb%$ |
      | $$$$$$$$$$$$$$$$$$$$$$$$$ | $$$$$$$$$$$$$$$$$$$$$$$$$ |
