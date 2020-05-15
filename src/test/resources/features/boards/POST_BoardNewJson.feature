@deleteBoard
Feature: Board Controller

  Background: Set the authentication
    Given I set authentication using API key and token

  @functional
  Scenario: Create a board with just basic required parameters using a Json body
    When I send a POST request to "/boards" with the following json body
      """
      {
	    "name" : "Hello New Board!"
      }
      """
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name | Hello New Board! |

  @smoke
  Scenario: Create a board with optional parameters using Json body
    When I send a POST request to "/boards" with the following json body
      """
      {
	    "name" : "Hello New Board!",
	    "desc" : "This is the description for the new board created.",
	    "prefs_background" : "green"
      }
      """
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Hello New Board!                                   |
      | desc             | This is the description for the new board created. |
      | prefs.background | green                                              |

  @functional
  Scenario: Create a board with description parameter with special chars using a Json body
    When I send a POST request to "/boards" with the following json body
    """
      {
	    "name" : "Hello Board (Json)!",
	    "desc" : "5ebcf20b25ab832271a56fb%$",
	    "prefs_background" : "green"
      }
     """
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Hello Board (Json)!       |
      | desc             | 5ebcf20b25ab832271a56fb%$ |
      | prefs.background | green                     |

  @functional
  Scenario: Create a board with empty description parameter with Json body
    When I send a POST request to "/boards" with the following json body
      """
      {
	    "name" : "Hello Board (Json)!",
	    "desc" : "",
	    "prefs_background" : "green"
      }
     """
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Hello Board (Json)! |
      | desc             | {empty}             |
      | prefs.background | green               |

  @functional
  Scenario Outline: Create a board with different background colors using a Json body
    When I send a POST request to "/boards" with the following json body
    """
      {
	    "name" : "Hello Board (Json)!",
	    "desc" : "This board was created sending a Json body.",
	    "prefs_background" : "<value>"
      }
     """                                        |
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Hello Board (Json)!                         |
      | desc             | This board was created sending a Json body. |
      | prefs.background | <color>                                     |
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
  Scenario: Create a board with invalid required parameters using a Json body
    When I send a POST request to "/boards" with the following json body
      """
      {
	    "namewwwww" : "Hello Board 32"
      }
      """
    Then I validate the response has status code 400

  @negative
  Scenario: Create a board with empty required parameter using a Json body
    When I send a POST request to "/boards" with the following json body
      """
      {
	    "name" : ""
      }
      """
    Then I validate the response has status code 400

  @negative
  Scenario: Create a board with basic required parameter with special chars using a Json body
    When I send a POST request to "/boards" with the following json body
      """
      {
	    "name" : "5ebcf20b25ab832271a56fb%$"
      }
      """
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name | 5ebcf20b25ab832271a56fb%$|

