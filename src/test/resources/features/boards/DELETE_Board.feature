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
  Scenario Outline: Delete a board without an existing id
    When I send a DELETE request to "/boards/<value>"
    Then I validate the response has status code 404
    Examples:
      | value                    |
      | {empty}                  |
      | bbbbbbbbbbbbbbbbbbbbbbbb |
      | 999999999999999999999999 |
      | 5ebcf20b2a5ab832271a56fb |
      | abcdef1234567890abcdeffF |

  @negative
  Scenario Outline: Delete a board with an invalid id
    When I send a DELETE request to "/boards/<value>"
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


