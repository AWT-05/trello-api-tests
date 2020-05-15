@deleteLabel @deleteBoard
Feature: Label Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created

  @functional
  Scenario Outline: Create a Label
  Valid color options: yellow, purple, blue, red, green, orange, black, sky, pink, lime

    When I send a POST request to "/labels" with the following json body
    """
      {
        "name" : "<Name>",
        "color" : "<Color>",
        "idBoard": "{board.id}"
      }
    """
    Then  I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following data
      | idBoard | {board.id} |
      | name    | <Name>     |
      | color   | <Color>    |

    Examples: required fields
      | Name    | Color  |
      | #$%     | blue   |
      | {empty} | lime   |
      | feature | yellow |
      | feature | purple |
      | feature | red    |
      | feature | green  |
      | feature | orange |
      | feature | black  |
      | feature | sky    |
      | feature | pink   |

  @smoke
  Scenario: Created without the "color" field

    When I send a POST request to "/labels" with the following json body
    """
      {
        "name" : "Test feature",
        "idBoard": "{board.id}"
      }
    """
    Then  I validate the response has status code 200
    And I save response as "label"
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {label.id}   |
      | idBoard | {board.id}   |
      | name    | Test feature |
