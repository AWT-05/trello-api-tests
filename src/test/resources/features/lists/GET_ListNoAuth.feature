@deleteBoard
Feature: List Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created
    And I have a list created

  @negative
  Scenario: Get List without authorization
    Given I don't set authentication
    When I send a GET request to "/lists/{list.id}"
    Then I validate the response has status code 401
    And I set authentication using API key and token