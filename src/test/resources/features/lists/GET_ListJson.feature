@featureMulti @deleteBoard
Feature: List Controller

  Background: authenticate user and set up a board
    Given I set authentication using API key and token
    And I have a board created
    And I have a list created

  @smoke @functional
  Scenario: Get a List
    When I send a GET request to "/lists/{list.id}"
    Then I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {list.id}     |
      | name    | {list.name}   |
      | closed  | {list.closed} |
      | pos     | {list.pos}    |
      | idBoard | {board.id}    |
