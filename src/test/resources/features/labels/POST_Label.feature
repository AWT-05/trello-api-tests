Feature: Label Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created

  @deleteLabel @deleteBoard
  Scenario: Create a Label
    When I send a POST request to "/labels" with the following parameters
      | name    | feature    |
      | color   | orange     |
      | idBoard | {board.id} |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following data
      | idBoard | {board.id} |
      | name    | feature    |
      | color   | orange     |
