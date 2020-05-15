@deleteBoard
Feature: List Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created

  @negative
  Scenario: Create a List without authorization
    Given I don't set authentication
    When I send a POST request to "/lists" with the following parameters
      | name    | Access Denied |
      | pos     | top           |
      | idBoard | {board.id}    |
    Then  I validate the response has status code 401
    And I set authentication using API key and token