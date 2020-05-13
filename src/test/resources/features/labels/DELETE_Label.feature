Feature: Label Controller
  Background: authenticate user and set up a label
    Given I set authentication using API key and token
    # default board saved as "board"
    And I have a board created
    # default label saved as "label"
    And I have a label created

  @deleteBoard
  Scenario: Delete a label created
    When I send a DELETE request to "/labels/{label.id}"
    Then I validate the response has status code 200
