@deleteLabel @deleteBoard
Feature: Label Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created
    And I have a label created

  @functional
  Scenario: Update a Label created

    When I send a PUT request to "/labels/{label.id}" with the following json body
    """
      {
        "name" : "test",
        "color": "lime"
      }
    """
    Then  I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following json
    """
      {
        "id": "{label.id}",
        "idBoard": "{board.id}",
        "name": "test",
        "color": "lime"
      }
    """

  Scenario Outline: Update a Label send only "name" field

    When I send a PUT request to "/labels/{label.id}" with the following json body
    """
      {
        "name" : "<Value>"
      }
    """
    Then  I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following json
    """
      {
        "id": "{label.id}",
        "idBoard": "{board.id}",
        "name": "<Value>",
        "color": "{label.color}"
      }
    """

    Examples: "name" values
      | Value         |
      | {empty}       |
      | !@#%^&*.$     |
      | OnlyName 1000 |

  Scenario Outline: Update a Label send only "color" field
  Valid color options: yellow, purple, blue, red, green, orange, black, sky, pink, lime

    When I send a PUT request to "/labels/{label.id}" with the following json body
    """
      {
        "color": "<Value>"
      }
    """
    Then  I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following json
    """
      {
        "id": "{label.id}",
        "idBoard": "{board.id}",
        "name": "{label.name}",
        "color": "<Value>"
      }
    """

    Examples: "color" values
      | Value  |
      | yellow |
      | purple |
      | blue   |
      | red    |
      | green  |
      | orange |
      | black  |
      | sky    |
      | pink   |
      | lime   |


  @negative
  Scenario Outline: Setting bad value "color" field
  Valid color options: yellow, purple, blue, red, green, orange, black, sky, pink, lime

    When I send a PUT request to "/labels/{label.id}" with the following json body
    """
      {
        "color": "<Bad Option>"
      }
    """
    Then  I validate the response has status code 400
    And I validate the response contains the following json
    """
    {
      "message": "invalid value for color",
      "error": "ERROR"
    }
    """

    Examples: "color" values
      | Bad Option |
      | azure      |
      | !@#$       |

  @smoke
  Scenario Outline: Update fields by path parameters

    When I send a PUT request to "/labels/{label.id}/<Field>" with the following json body
    """
      {
        "value": "<Value>"
      }
    """
    Then  I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {label.id} |
      | idBoard | {board.id} |
      | <Field> | <Value>    |

    Examples: "color" values
      | Field | Value      |
      | name  | Test  1000 |
      | name  | {empty}    |
      | color | lime       |

  @functional
  Scenario Outline: No update "id" and "idBoard" fields

    When I send a PUT request to "/labels/{label.id}" with the following json body
    """
      {
          "id": "<Value>",
          "idBoard": "<Value>"
      }
    """
    Then  I validate the response has status code 200
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

    Examples: "idBoard" values
      | Value                    |
      | {empty}                  |
      | 5ebabeeb076f7c01876e92f8 |
