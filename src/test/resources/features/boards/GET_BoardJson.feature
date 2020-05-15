@deleteBoard
Feature: Board Controller

  Background: Authenticate user and set up a board
    Given I set authentication using API key and token
    And I have a board created

  @functional @smoke
  Scenario: Get a created board
    When I send a GET request to "/boards/{board.id}"
    Then I validate the response has status code 200
    And I validate the response body should match with "/boards/getBoardSchema.json" JSON schema
    And I validate the response contains the following data
      | id               | {board.id}               |
      | name             | {board.name}             |
      | desc             | {board.desc}             |
      | prefs.background | {board.prefs.background} |

  @negative
  Scenario Outline: Try to get a board with an invalid id
    When I send a GET request to "/boards/<value>"
    Then I validate the response has status code 400
    Examples:
      | value                         |
      | zzzzzzzzzzzzzzzzzzzzzzzz      |
      | ZZZZZZZZZZZZZZZZZZZZZZZZ      |
      | $$$$$$$$$$$$$$$$$$$$$$$$      |
      | ####!!!!!..abcd.........      |
      | 12345679asdfqwerWERSDFAA      |
      | aaaaaaaaaaaaaaaaaaa           |
      | aaaaaaaaaaaaaaaaaaaaaaaaaaaaa |

  @negative
  Scenario Outline: Try to get a board without an existing id
    When I send a GET request to "/boards/<value>"
    Then I validate the response has status code 404
    Examples:
      | value                    |
      | {empty}                  |
      | bbbbbbbbbbbbbbbbbbbbbbbb |
      | 999999999999999999999999 |
      | 5ebcf20b2a5ab832271a56fb |
      | abcdef1234567890abcdeffa |
