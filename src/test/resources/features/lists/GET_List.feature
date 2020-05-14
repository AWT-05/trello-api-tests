@featureMulti @deleteBoard
Feature: List Controller

  Background: authenticate user and set up a board
    Given I set authentication using API key and token
    And I have a board created
    And I have a list created

  @smoke
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

  @functional
  Scenario Outline: Get field(s) of a List
    When I send a GET request to "/lists/{list.id}" with the following parameters
      | fields | <field_value> |
    Then I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | <field_value> | <field_expected> |
    Examples:
      | field_value | field_expected |
      | id          | {list.id}      |
      | name        | {list.name}    |
      | pos         | {list.pos}     |
      | closed      | {list.closed}  |
      | idBoard     | {list.idBoard} |

  @functional
  Scenario: Get all fields of a List
    When I send a GET request to "/lists/{list.id}" with the following parameters
      | fields | all |
    Then I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {list.id}     |
      | name    | {list.name}   |
      | closed  | {list.closed} |
      | pos     | {list.pos}    |
      | idBoard | {board.id}    |

  @functional
  Scenario Outline: Get field(s) of a List with non-existent field value
    When I send a GET request to "/lists/{list.id}" with the following parameters
      | fields | <field_non_value> |
    Then I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id | {list.id} |
    Examples:
      | field_non_value |
      | {empty}         |
      | 1               |
      | all1            |
      | nonexistent     |

  @negative
  Scenario: Get a List without id
    When I send a GET request to "/lists/{empty}"
    Then I validate the response has status code 404

  @negative
  Scenario Outline: Get a List with non-acceptable id
    When I send a GET request to "/lists/<value>"
    Then I validate the response has status code 400
    Examples:
      | value                            |
      | 1                                |
      | amIAcceptedNow2                  |
      | ()()                             |
      | %&                               |
      | qwertyuiop09876lkjhgfdsa12345zxc |
      | 5eba06ca71gd2su1213j1jas         |

  @negative
  Scenario Outline: Get a List with non-existent id
    When I send a GET request to "/lists/<value>"
    Then I validate the response has status code 404
    Examples:
      | value                    |
      | 000000000000ffffffffffff |
      | 000000000000000000000000 |
      | ffffffffffffffffffffffff |

