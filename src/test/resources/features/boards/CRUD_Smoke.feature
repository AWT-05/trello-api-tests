@deleteBoard @Smoke
Feature: Board Controller

  Background: Set authentication and create a board
    Given I set authentication using API key and token
    When I send a POST request to "/boards" with the following parameters
      | name | New basic board for CRUD |
    And I save response as "board"
    Then I validate the response has status code 200

  Scenario: Get board created
    When I send a GET request to "/boards/{board.id}"
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/getBoardSchema.json" JSON schema

  Scenario: Update board created
    When I send a PUT request to "/boards/{board.id}" with the following parameters
      | name | Boards name has been updated |
    Then I validate the response has status code 200
    And I validate the response body should match with "boards/getBoardSchema.json" JSON schema

  Scenario: Delete board created
    When I send a DELETE request to "/boards/{board.id}"
    Then I validate the response has status code 200
