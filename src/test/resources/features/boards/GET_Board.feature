
Feature: List Controller

  Background: authenticate user and set up a board
    Given I set authentication using API key and token
    And I have a board created

  @functional @deleteBoard
  Scenario: Get a created board
    When I send a GET request to "/boards/{board.id}"
    Then I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {board.id}     |
      | name    | {board.name}   |
      | closed  | {board.closed} |
      | pos     | {board.pos}    |
      | idBoard | {board.id}    |

  @negative @deleteBoard
  Scenario: Get a List without id
    When I send a GET request to "/lists/{empty}"
    Then I validate the response has status code 404

  @negative @deleteBoard
  Scenario Outline: Get a List with non-acceptable id
    When I send a GET request to "/lists/<value>"
    Then I validate the response has status code 400
    Examples:
      | value                                |
      | 1                                    |
      | asdasd                               |
      | #                                    |
      | qwertyuiop09876lkjhgfdsa12345zxcvbnm |