@deleteLabel @deleteBoard
Feature: Label Controller

  Background: authenticate user and set up a label
    Given I set authentication using API key and token
    And I have a board created
    And I have a label created

  @smoke
  Scenario Outline: Send any value in the get body no affect to response

    When I send a GET request to "/labels/{label.id}" with the following json body
    """
      {
        "<Field>": "<Value>"
      }
    """
    Then I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following json
    """
      {
          "id": "{label.id}",
          "idBoard": "{board.id}",
          "name": "{label.name}",
          "color": "{label.color}"
      }
    """

    Examples: fields values to show the all content
      | Field   | Value   |
      | fields  | all     |
      | {empty} | {empty} |
      | no      | valid   |
      | name    | test    |
      | color   | blue    |
