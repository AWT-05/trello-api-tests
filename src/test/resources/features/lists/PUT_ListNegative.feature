@deleteBoard
Feature: List Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created
    And I have a list created

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
  Scenario Outline: Update a List with invalid id values
    When I send a PUT request to "/lists/<id_value>" with the following parameters
      | name       | Almost updated |
      | closed     | true           |
      | pos        | bottom         |
      | subscribed | true           |
    Then  I validate the response has status code 400
    Examples:
      | id_value                  |
      | 5ea9d4ece645a70dd316bfe   |
      | 5ea9d4ece645a70dd316bfe31 |

  @negative
  Scenario: Update a List with empty id value
    When I send a PUT request to "/lists/{empty}" with the following parameters
      | name       | Updated non existent |
      | closed     | true                 |
      | pos        | bottom               |
      | subscribed | true                 |
    Then  I validate the response has status code 404

  @negative
  Scenario Outline: Archive (close) a List with invalid values
    When I send a PUT request to "/lists/{list.id}/closed" with the following parameters
      | value | <close_value> |
    Then I validate the response has status code 400
    Examples:
      | close_value |
      | falso       |
      | {empty}     |
