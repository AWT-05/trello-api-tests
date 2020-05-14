@Smoke  @deleteBoard
Feature: Boards Controller

  Background: authenticate user and set up a board
    Given I set authentication using API key and token
    And I have a board created

  @functional
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
  Scenario Outline: Get a List with an invalid id
    When I send a GET request to "/boards/<value>"
    Then I validate the response has status code 400
    Examples:
      | value                      |
      | abcd                       |
      | 1234                       |
      | ####!!!!!                  |
      | 12345679asdfqwerrtuyhgzxcv |

  @negative
  Scenario: Get a List without id
    When I send a GET request to "/boards/{empty}"
    Then I validate the response has status code 404
