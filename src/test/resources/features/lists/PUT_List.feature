@deleteBoard
Feature: List Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created
    And I have a list created

  @smoke
  Scenario: Update a List created
    When I send a PUT request to "/lists/{list.id}" with the following parameters
      | name       | Ready for QA |
      | closed     | true         |
      | pos        | bottom       |
      | subscribed | true         |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {list.id}    |
      | pos     | 65536        |
      | name    | Ready for QA |
      | closed  | true         |
      | idBoard | {board.id}   |

  @functional
  Scenario Outline: Update a List's name
    When I send a PUT request to "/lists/{list.id}" with the following parameters
      | name | <name_value> |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {list.id}     |
      | pos     | {list.pos}    |
      | name    | <name_value>  |
      | closed  | {list.closed} |
      | idBoard | {board.id}    |
    Examples:
      | name_value      |
      | Ready for merge |
      | "I'm not ready" |
      | %High Ground%   |

  @functional
  Scenario Outline: Update a List's archived status
    When I send a PUT request to "/lists/{list.id}" with the following parameters
      | closed | <closure> |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {list.id}      |
      | pos     | {list.pos}     |
      | name    | {list.name}    |
      | closed  | <closed_value> |
      | idBoard | {board.id}     |
    Examples:
      | closure | closed_value |
      | true    | true         |
      | 1       | true         |
      | false   | false        |
      | 0       | false        |

  @functional
  Scenario Outline: Update a List's position
    When I send a PUT request to "/lists/{list.id}" with the following parameters
      | pos | <position> |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {list.id}      |
      | pos     | <pos_expected> |
      | name    | {list.name}    |
      | closed  | {list.closed}  |
      | idBoard | {board.id}     |
    Examples:
      | position | pos_expected |
      | top      | 4096         |
      | 2        | 2            |
      | 40000    | 40000        |
      | bottom   | 65536        |

  @functional
  Scenario Outline: Update a List's subscribed field
    Given I send a PUT request to "/lists/{list.id}" with the following parameters
      | subscribed | <sub_value> |
    When I send a GET request to "/lists/{list.id}" with the following parameters
      | fields | subscribed |
    Then I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id         | {list.id}   |
      | subscribed | <sub_value> |
    Examples:
      | sub_value |
      | true      |
      | false     |

  @smoke
  Scenario Outline: Archive (close) a List
    When I send a PUT request to "/lists/{list.id}/closed" with the following parameters
      | value | <close_value> |
    Then I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {list.id}        |
      | pos     | {list.pos}       |
      | name    | {list.name}      |
      | closed  | <close_expected> |
      | idBoard | {board.id}       |
    Examples:
      | close_value | close_expected |
      | true        | true           |
      | 1           | true           |
      | false       | false          |
      | 0           | false          |

  @functional
  Scenario Outline: Update a field on a List
    When I send a PUT request to "/lists/{list.id}/<field>" with the following parameters
      | value | <field_value> |
    Then I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {list.id}     |
      | <field> | <field_value> |
    Examples:
      | field | field_value |
      | name  | Review New  |
      | name  | "Not Jedi"  |
      | pos   | 40000       |
      | pos   | 30000       |

  @negative
  Scenario Outline: Update a List's field with empty values
    When I send a PUT request to "/lists/{list.id}" with the following parameters
      | <field_name> | <field_value> |
    Then  I validate the response has status code 400
    Examples:
      | field_name | field_value |
      | name       | {empty}     |
      | closed     | {empty}     |
      | subscribed | {empty}     |
      | idBoard    | {empty}     |

  @negative
  Scenario Outline: Update a List with non-acceptable id values
    When I send a PUT request to "/lists/<id_value>" with the following parameters
      | name       | Almost updated |
      | closed     | true         |
      | pos        | bottom       |
      | subscribed | true         |
    Then  I validate the response has status code 400
    Examples:
      | id_value                  |
      | 5ea9d4ece645a70dd316bfe   |
      | 5ea9d4ece645a70dd316bfe31 |

  @negative
  Scenario Outline: Update a List with non-existent id values
    When I send a PUT request to "/lists/<id_value>" with the following parameters
      | name       | Updated non existent |
      | closed     | true         |
      | pos        | bottom       |
      | subscribed | true         |
    Then  I validate the response has status code 404
    Examples:
      | id_value                 |
      | {empty}                  |
      | 000000000000ffffffffffff |

  @smoke
  Scenario Outline: Archive (close) a List with invalid values
    When I send a PUT request to "/lists/{list.id}/closed" with the following parameters
      | value | <close_value> |
    Then I validate the response has status code 400
    Examples:
      | close_value |
      | falso       |
      | {empty}     |
