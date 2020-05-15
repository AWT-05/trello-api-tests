@deleteBoard
Feature: List Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created
    And I have a list created

  @negative
  Scenario: Update a List created without authorization
    Given I don't set authentication
    When I send a PUT request to "/lists/{list.id}" with the following parameters
      | name       | Ready for QA |
      | closed     | true         |
      | pos        | bottom       |
      | subscribed | true         |
    Then  I validate the response has status code 401
    And I set authentication using API key and token