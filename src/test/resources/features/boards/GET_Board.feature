Feature: Boards Controller

  Background: authenticate user and set up a board
    Given I set authentication using API key and token
    And I have a board created

  @functional @deleteBoard
  Scenario: Get a created board
    When I send a GET request to "/boards/{board.id}"
    Then I validate the response has status code 200
    And I validate the response body should match with "/boards/getBoardSchema.json" JSON schema
    And I validate the response contains the following data
      | id               | {board.id}               |
      | name             | {board.name}             |
      | desc             | {board.desc}             |
      | prefs.background | {board.prefs.background} |

