@deleteBoard
Feature: List Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created

  @negative
  Scenario: Create a List with invalid name
    When I send a POST request to "/lists" with the following parameters
      | name    | {empty}    |
      | pos     | top        |
      | idBoard | {board.id} |
    Then  I validate the response has status code 400

  @negative
  Scenario: Create a List with empty idBoard
    When I send a POST request to "/lists" with the following parameters
      | name    | Normal Name |
      | pos     | top         |
      | idBoard | {empty}     |
    Then  I validate the response has status code 400

  @negative
  Scenario Outline: Create a List with invalid idBoard
    When I send a POST request to "/lists" with the following parameters
      | name    | Normal Name    |
      | pos     | top            |
      | idBoard | <non-existent> |
    Then  I validate the response has status code 400
    Examples:
      | non-existent              |
      | $#                        |
      | 000000000000fffffffffffff |
