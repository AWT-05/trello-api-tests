@deleteBoard
Feature: Board Controller

  Background: Authenticate user and set up a board
    Given I set authentication using API key and token
    And I have a board created

  @functional @smoke
  Scenario: Update a created board using a Json body
    When I send a PUT request to "/boards/{board.id}" with the following json body
      """
      {
	    "name" : "Board name updated",
	    "desc" : "Description has been updated using a Json",
	    "prefs/background" : "lime"
      }
      """
    Then I validate the response has status code 200
    And I validate the response body should match with "/boards/putBoardSchema.json" JSON schema
    And I validate the response contains the following data
      | id               | {board.id}                                |
      | name             | Board name updated                        |
      | desc             | Description has been updated using a Json |
      | prefs.background | lime                                      |

  @negative @smoke
  Scenario: Update a created board with invalid parameters in a Json body
    When I send a PUT request to "/boards/{board.id}" with the following json body
      """
      {
	    "nameddddddddd" : "Board name updated",
	    "desc" : "Description has been updated using a Json",
	    "prefs/background" : "lime"
      }
      """
    Then I validate the response has status code 400

  @negative
  Scenario Outline: Using json body, update a board with invalid ids
    When I send a PUT request to "/boards/<value>" with the following json body
      """
      {
	    "name" : "Board name updated",
	    "desc" : "Description has been updated using a Json",
	    "prefs/background" : "lime"
      }
      """
    Then I validate the response has status code 400
    Examples:
      | value                      |
      | abcd                       |
      | 1234                       |
      | ####!!!!!                  |
      | 12345679asdfqwerrtuyhgzxcv |

  @negative
  Scenario Outline: Using json body, update a board with invalid ids
    When I send a PUT request to "/boards/{board.id}" with the following json body
      """
      {
	    "name" : "Board name updated!",
	    "desc" : "Description has been updated using a Json",
	    "prefs/background" : "<value>"
      }
      """
    Then I validate the response has status code 200
    And I validate the response body should match with "/boards/putBoardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Board name updated!                       |
      | desc             | Description has been updated using a Json |
      | prefs.background | <color>                                   |
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
