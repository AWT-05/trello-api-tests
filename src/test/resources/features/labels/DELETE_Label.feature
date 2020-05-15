@deleteBoard
Feature: Label Controller

  Background: authenticate user and set up a label
    Given I set authentication using API key and token
    And I have a board created
    And I have a label created

  @functional
  Scenario: Delete a label created

    When I send a DELETE request to "/labels/{label.id}"
    Then I validate the response has status code 200
      When I send a GET request to "/labels/{label.id}"
      Then I validate the response has status code 404
