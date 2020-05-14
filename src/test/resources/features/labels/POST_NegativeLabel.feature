@negative @deleteBoard
Feature: Label Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created

  @deleteBoard
  Scenario: Created without the "name" field

    When I send a POST request to "/labels" with the following parameters
      | color   | lima       |
      | idBoard | {board.id} |
    Then  I validate the response has status code 400
    And I validate the response contains the following value
    """
    invalid value for name
    """

  @smoke
  Scenario Outline: Created with invalid values fields
  The field "name" accept any value

    When I send a POST request to "/labels" with the following parameters
      | name    | <Name>    |
      | color   | <Color>   |
      | idBoard | <IdBoard> |
    Then  I validate the response has status code 400
    And I validate the response body should match with "/labels/badRequestSchema.json" JSON schema

    Examples: required fields
      | Name     | Color | IdBoard                  |
      | TestName | None  | {board.id}               |
      | TestName | 3     | {board.id}               |
      | TestName | lima  | {empty}                  |
      | TestName | lima  | 000000000000000000000000 |
