Feature: Board Controller

  Background: Set authentication and create a board
    Given I set authentication using API key and token
    When I send a POST request to "/boards" with the following parameters
      | name | new_test_trello_api_board |
    And I save response as "board"
    Then I validate the response has status code 200

  Scenario: Get board created
    When I send a GET request to "/boards/{board.id}"
    Then I validate the response has status code 200

  Scenario: Update board created
    When I send a PUT request to "/boards/{board.id}" with the following parameters
      | displayName | Name Updated |
      | desc        | Only MOI     |
    Then I validate the response has status code 200


  Scenario: Delete board created
    When I send a DELETE request to "/boards/{board.id}"
    Then I validate the response has status code 200