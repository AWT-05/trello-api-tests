Feature: Label Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created
    And I have a label created

  @deleteLabel @deleteBoard
  Scenario: Update a Label created
    When I send a PUT request to "/labels/{label.id}" with the following parameters
      | name  | test |
      | color | lime |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {label.id} |
      | idBoard | {board.id} |
      | name    | test       |
      | color   | lime       |
