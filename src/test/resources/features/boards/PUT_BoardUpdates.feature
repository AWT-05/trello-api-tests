@deleteBoard
Feature: Board Controller

  Background: Authenticate user and set up a board
    Given I set authentication using API key and token
    And I have a board created

  @functional @smoke
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

  @negative @smoke
  Scenario: Update a created board with invalid parameters
    When I send a PUT request to "/boards/{board.id}" with the following parameters
      | nameddddddddd    | Board name updated           |
      | descriptionqwed  | Description has been updated |
      | prefs.background | lime                         |
    Then I validate the response has status code 200

  @functional
  Scenario Outline: Update a created board different background colors
    When I send a PUT request to "/boards/{board.id}" with the following parameters
      | name             | Board name updated           |
      | desc             | Description has been updated |
      | prefs/background | <value>                      |
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "/boards/putBoardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Board name updated           |
      | desc             | Description has been updated |
      | prefs.background | <color>                      |
    Examples:
      | value  | color  |
      | green  | green  |
      | blue   | blue   |
      | pink   | pink   |
      | purple | purple |
      | lime   | lime   |
      | sky    | sky    |
      | red    | red    |
      | grey   | grey   |

  @functional
  Scenario: Update a created board with empty description parameter
    When I send a PUT request to "/boards/{board.id}" with the following parameters
      | name             | Board name updated |
      | desc             | {empty}            |
      | prefs/background | green              |
    And I save the id value to clean "board" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "/boards/putBoardSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | Board name updated |
      | desc             | {empty}            |
      | prefs.background | green              |

  @negative
  Scenario Outline: Update a board with invalid ids
    When I send a PUT request to "/boards/<value>" with the following parameters
      | name             | Board name updated           |
      | desc             | Description has been updated |
      | prefs/background | lime                         |
    Then I validate the response has status code 400
    Examples:
      | value                         |
      | gggggggggggggggggggggggg      |
      | GGGGGGGGGGGGGGGGGGGGGGGG      |
      | $$$$$$$$$$$$$$$$$$$$$$$$      |
      | aaaaaaaaaaaaaaaaaaa           |
      | aaaaaaaaaaaaaaaaaaaaaaaaaaaaa |

  @negative
  Scenario Outline: Update a board with empty ids
    When I send a PUT request to "/boards/<value>" with the following parameters
      | name             | Board name updated           |
      | desc             | Description has been updated |
      | prefs/background | lime                         |
    Then I validate the response has status code 404
    Examples:
      | value   |
      | {empty} |
      |         |

  @negative @skipScenario
  Scenario Outline: Update a board without an existing id
    When I send a PUT request to "/boards/<value>" with the following parameters
      | name             | Board name updated           |
      | desc             | Description has been updated |
      | prefs/background | lime                         |
    Then I validate the response has status code 404
    Examples:
      | value                    |
      | 5ebcf20b2a5ab832271a56fA |
