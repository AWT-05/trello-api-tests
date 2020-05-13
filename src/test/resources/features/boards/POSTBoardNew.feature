@functional
Feature: Boards Controller

  Background: Set the authentication
    Given I set authentication using API key and token

  @functional @deleteBoard
  Scenario: Create a board using Json body with just basic required parameters
    When I send a POST request to "/boards" with the following json body
      """
      {
	    "name" : "Hello Board4!"
      }
      """
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name | Hello Board4! |

  @deleteBoard
  Scenario: Create a board using Json body with optional parameters
    When I send a POST request to "/boards" with the following json body
      """
      {
	    "name" : "Hello Board5!",
	    "desc" : "This is the description for the new board created."
      }
      """
#    see to send whitn invalid patters (see documentation for this) changed Pups and background
#  "powerUps" : "calendar", 	    "prefs_background" : "green",
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/boardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Hello Board5!                                      |
      | desc             | This is the description for the new board created. |
#      | prefs_background | green                                              |

