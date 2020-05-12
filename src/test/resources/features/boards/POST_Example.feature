Feature: Board Controller

  Background: Set authentication and create a board
    Given I set authentication using API key and token

  Scenario: Create a board
    When I send a POST request to "/boards" with the following parameters
      | name | new_test_trello_api_board |
    And I save response as "board"
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/getBoardSchema.json" JSON schema
    And I validate the response contains the following data
      | name | new_test_trello_api_board |
