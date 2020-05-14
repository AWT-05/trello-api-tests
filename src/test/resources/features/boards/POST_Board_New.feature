@Smoke
Feature: Boards Controller

  Background: Set the authentication
    Given I set authentication using API key and token

  @functional @deleteBoard
  Scenario: Create a board using Json body with just basic required parameters
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

  @deleteBoard
  Scenario: Create a board using Json body with optional parameters
    When I send a POST request to "/boards" with the following json body
      """
      {
	    "name" : "Hello New Board!",
	    "desc" : "This is the description for the new board created.",
	    "prefs_background" : "green"
      }
      """
#    see to send whitn invalid patters (see documentation for this) changed Pups and background
#  "powerUps" : "calendar",
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Hello New Board!                                   |
      | desc             | This is the description for the new board created. |
      | prefs.background | green                                              |

  @negative @deleteBoard
  Scenario: Create a board using Json body with invalid required parameters
    When I send a POST request to "/boards" with the following json body
      """
      {
	    "namew" : "Hello Board 32"
      }
      """
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 400
#    And I validate the response body should match with "boards/boardSchema.json" JSON schema
#    And I validate the response contains the following data
#      | name | Hello Board4! |#
#  Validate a negative sending empty
#  invalid http methods?
