@deleteBoard
Feature: List Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created

  @smoke
  Scenario Outline: Create a List
    When I send a POST request to "/lists" with the following parameters
      | name    | <name_value> |
      | pos     | <pos_value>  |
      | idBoard | {board.id}   |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | name    | <name_expected> |
      | closed  | false           |
      | pos     | <pos_expected>  |
      | idBoard | {board.id}      |
    Examples:
      | pos_value | pos_expected | name_value       | name_expected    |
      | top       | 8192         | Reviewed         | Reviewed         |
      | bottom    | 65536        | With numbers 123 | With numbers 123 |
      | 40000     | 40000        | ----             | ----             |

  @negative
  Scenario: Create a List without valid name
    When I send a POST request to "/lists" with the following parameters
      | name    | {empty}    |
      | pos     | top        |
      | idBoard | {board.id} |
    Then  I validate the response has status code 400

  @negative
  Scenario Outline: Create a List without valid idBoard
    When I send a POST request to "/lists" with the following parameters
      | name    | Normal Name    |
      | pos     | top            |
      | idBoard | <non-existent> |
    Then  I validate the response has status code 400
    Examples:
      | non-existent              |
      | {empty}                   |
      | $#                        |
      | 00000000000ffffffffffff   |
      | 000000000000fffffffffffff |

  @functional
  Scenario: Create a List copy of another List
    Given I have a list created
    When I send a POST request to "/lists" with the following parameters
      | name         | Reviewed copy |
      | idListSource | {list.id}     |
      | idBoard      | {board.id}    |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | name    | Reviewed copy |
      | closed  | false         |
      | idBoard | {board.id}    |

  @negative
  Scenario Outline: Create a List copy of another List without source id
    Given I have a list created
    When I send a POST request to "/lists" with the following parameters
      | name         | Reviewed copy |
      | idListSource | <source_id>   |
      | idBoard      | {board.id}    |
    Then  I validate the response has status code 400
    Examples:
      | source_id                |
      | {empty}                  |
      | 00000000000fffffffffffff |

  @negative
  Scenario Outline: Create a List copy of another List with non-valid source id
    Given I have a list created
    When I send a POST request to "/lists" with the following parameters
      | name         | Reviewed copy |
      | idListSource | <non-valid>   |
      | idBoard      | {board.id}    |
    Then  I validate the response has status code 400
    Examples:
      | non-valid                 |
      | $#                        |
      | 00000000000ffffffffffff   |
      | 000000000000fffffffffffff |