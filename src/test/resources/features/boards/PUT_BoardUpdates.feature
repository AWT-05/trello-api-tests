@deleteBoard
Feature: Board Controller

  Background: Authenticate user and set up a board
    Given I set authentication using API key and token
    And I have a board created

  @functional @Smoke
  Scenario: Update a created board
    When I send a PUT request to "/boards/{board.id}" with the following parameters
      | name             | Board name updated           |
      | desc             | Description has been updated |
      | prefs/background | lime                         |
    Then I validate the response has status code 200
    And I validate the response body should match with "/boards/putBoardSchema.json" JSON schema
    And I validate the response contains the following data
      | id               | {board.id}                   |
      | name             | Board name updated           |
      | desc             | Description has been updated |
      | prefs.background | lime                         |

  @negative @Smoke
  Scenario: Update a created board with invalid parameters
    When I send a PUT request to "/boards/{board.id}" with the following parameters
      | nameddddddddd    | Board name updated           |
      | description      | Description has been updated |
      | prefs_background | lime                         |
    Then I validate the response has status code 400

  @negative
  Scenario Outline: Update a board with invalid ids
    When I send a PUT request to "/boards/<value>" with the following parameters
      | name             | Board name updated           |
      | desc             | Description has been updated |
      | prefs/background | lime                         |
    Then I validate the response has status code 400
    Examples:
      | value                      |
      | abcd                       |
      | 1234                       |
      | ####!!!!!                  |
      | 12345679asdfqwerrtuyhgzxcv |
