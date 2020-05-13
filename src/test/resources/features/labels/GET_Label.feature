Feature: Label Controller

  Background: authenticate user and set up a label
    Given I set authentication using API key and token
    # default board saved as "board"
    And I have a board created
    # default label saved as "label"
    And I have a label created

  @deleteLabel @deleteBoard
  Scenario: Get a label created
    When I send a GET request to "/labels/{label.id}"
    Then I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {label.id}    |
      | idBoard | {board.id}    |
      | name    | {label.name}  |
      | color   | {label.color} |

