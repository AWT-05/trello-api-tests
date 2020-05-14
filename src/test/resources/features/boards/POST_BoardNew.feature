@deleteBoard
Feature: Boards Controller

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
  Scenario: Create a board with basic required parameter with simbols
    When I send a POST request to "/boards" with the following parameters
      | name | $%&$%&$%&$%& 4$%& |
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name | $%&$%&$%&$%& 4$%& |





  #    see to send whitn invalid patters (see documentation for this) changed Pups and background
#  "powerUps" : "calendar",

  #    And I validate the response body should match with "boards/boardSchema.json" JSON schema
#    And I validate the response contains the following data
#      | name | Hello Board4! |#
#  Validate a negative sending empty
#  invalid http methods?

  @negative
  Scenario Outline: Create a board with basic required parameter
    When I send a POST request to "/boards" with the following parameters
      | name | <value> |
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name | {board.name} |
    Examples:
      | value              |
      | $%&$%&$%&$%& 4$%&  |
      | bbbbbbbbbbbbbbbbbb |
      | 99999999999999999  |
      | abcdef12.0abcdeffF |