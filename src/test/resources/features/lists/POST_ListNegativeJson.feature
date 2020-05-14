@deleteBoard
Feature: List Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created

  @negative
  Scenario: Create a List without valid name
    When I send a POST request to "/lists" with the following json body
      """
      {
	    "name": "{empty}",
	    "pos": "top",
	    "idBoard": "{board.id}"
      }
      """
    Then  I validate the response has status code 400

  @negative
  Scenario Outline: Create a List without valid idBoard
    When I send a POST request to "/lists" with the following parameters
      """
      {
	    "name": "Normal Name",
	    "pos": "top",
	    "idBoard": "<non-existent>"
      }
      """
    Then  I validate the response has status code 400
    Examples:
      | non-existent              |
      | {empty}                   |
      | $#                        |
      | 00000000000ffffffffffff   |
      | 000000000000fffffffffffff |
