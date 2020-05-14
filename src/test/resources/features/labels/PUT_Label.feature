@deleteLabel @deleteBoard
Feature: Label Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created
    And I have a label created

  @functional
  Scenario: Update a Label created

    When I send a PUT request to "/labels/{label.id}" with the following parameters
      | name  | test |
      | color | lime |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {label.id} |
      | idBoard | {board.id} |
      | name    | test       |
      | color   | lime       |


  Scenario Outline: Update a Label send only "name" field

    When I send a PUT request to "/labels/{label.id}" with the following parameters
      | name | <Value> |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {label.id}    |
      | idBoard | {board.id}    |
      | name    | <Value>       |
      | color   | {label.color} |

    Examples: "name" values
      | Value    |
      | {empty}  |
      | OnlyName |


  Scenario Outline: Update a Label send only "color" field
  Valid color options: yellow, purple, blue, red, green, orange, black, sky, pink, lime

    When I send a PUT request to "/labels/{label.id}" with the following parameters
      | color | <Input> |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {label.id}   |
      | idBoard | {board.id}   |
      | name    | {label.name} |
      | color   | <Expected>   |

    Examples: "color" values
      | Input   | Expected |
      | {empty} | {null}   |
      | {null}  | {null}   |
      | sky     | sky      |

  @smoke
  Scenario Outline: Update fields by path parameters

    When I send a PUT request to "/labels/{label.id}/<Field>" with the following parameters
      | value | <Value> |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {label.id} |
      | idBoard | {board.id} |
      | <Field> | <Value>    |

    Examples: "color" values
      | Field | Value   |
      | name  | Test    |
      | name  | {empty} |
      | color | lime    |
      | color | black   |

  @functional
  Scenario Outline: No update "id" and "idBoard" fields
    When I send a PUT request to "/labels/{label.id}" with the following parameters
      | id      | <Value> |
      | idBoard | <Value> |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {label.id}    |
      | idBoard | {board.id}    |
      | name    | {label.name}  |
      | color   | {label.color} |

    Examples: "idBoard" values
      | Value                    |
      | {empty}                  |
      | 5ebabeeb076f7c01876e92f8 |
      | Test value               |
      | 10                       |
      | *                        |
      | #                        |


  @negative
  Scenario Outline: Setting bad value "color" field
  Valid color options: yellow, purple, blue, red, green, orange, black, sky, pink, lime

    When I send a PUT request to "/labels/{label.id}" with the following parameters
      | color | <Bad Option> |
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
      | cyan       |
      | 1          |
