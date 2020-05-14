@deleteLabel @deleteBoard
Feature: Label Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created

  @functional
  Scenario Outline: Create a Label

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
      | Name     | Color  |
      | TestName | yellow |
      | {empty}  | lime   |
      | #$%      | blue   |
      | 123      | sky    |


  Scenario Outline: Created with the "color" field empty or null

    When I send a POST request to "/labels" with the following json body
    """
      {
        "name" : "Test feature",
        "color" : "<Input>",
        "idBoard": "{board.id}"
      }
    """
    Then  I validate the response has status code 200
    And I save response as "label"
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following json
    """
    {
        "id": "{label.id}",
        "idBoard": "{board.id}",
        "name": "Test feature",
        "color": null,
        "limits": {
        }
    }
    """

    Examples: "color" values
      | Input   |
      | {empty} |
#      | {null}  |

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
    And I validate the response contains the following json
    """
    {
        "id": "{label.id}",
        "idBoard": "{board.id}",
        "name": "Test feature",
        "color": null,
        "limits": {
        }
    }
    """
