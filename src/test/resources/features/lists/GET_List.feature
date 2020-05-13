@featureMulti @deleteBoard
Feature: List Controller

  Background: authenticate user and set up a board
    Given I set authentication using API key and token
    And I have a board created
    And I have a list created

  @functional
  Scenario: Get a List
    When I send a GET request to "/lists/{list.id}"
    Then I validate the response has status code 200
    And I validate the response body should match with "/lists/listGetSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {list.id}     |
      | name    | {list.name}   |
      | closed  | {list.closed} |
      | pos     | {list.pos}    |
      | idBoard | {board.id}    |

  @negative
  Scenario: Get a List without id
    When I send a GET request to "/lists/{empty}"
    Then I validate the response has status code 404

  @negative
  Scenario Outline: Get a List with non-acceptable id
    When I send a GET request to "/lists/<value>"
    Then I validate the response has status code 400
    Examples:
      | value                                |
      | 1                                    |
      | asdasd                               |
      | #                                    |
      | qwertyuiop09876lkjhgfdsa12345zxcvbnm |