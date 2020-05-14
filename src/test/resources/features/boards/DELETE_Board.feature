@deleteBoard
Feature: Boards Controller

  Background: Authenticate user and set up a label
    Given I set authentication using API key and token
    And I have a board created

  @functional
  Scenario: Delete a created board
    When I send a DELETE request to "/boards/{board.id}"
    Then I validate the response has status code 200

  @negative
  Scenario: Delete a board without an id
    When I send a GET request to "/boards/{empty}"
    Then I validate the response has status code 404