@deleteLabel @deleteBoard
Feature: Label Controller

  Background: authenticate user and set up a label
    Given I set authentication using API key and token
    And I have a board created
    And I have a label created

  @functional
  Scenario Outline: Gets a label with all fields
  If we don't send a value for "fields" the default is "all"

    When I send a GET request to "/labels/{label.id}" with the following parameters
      | <Field> | <Value> |
    Then I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {label.id}    |
      | idBoard | {board.id}    |
      | name    | {label.name}  |
      | color   | {label.color} |

    Examples: fields values to show the all content
      | Field   | Value   |
      | fields  | all     |
      | {empty} | {empty} |

  @functional
  Scenario Outline: Gets a field label specifying the "fields" field
  Only work if sends it as query params

    When I send a GET request to "/labels/{label.id}" with the following parameters
      | fields | <Field> |
    Then I validate the response has status code 200
    And I validate the response contains the following json
    """
      {
        "id": "{label.id}",
        "<Field>": "<Value>"
      }
    """

    Examples: Field requested
      | Field   | Value         |
      | idBoard | {board.id}    |
      | name    | {label.name}  |
      | color   | {label.color} |

  @negative
  Scenario Outline: Gets only the "id" value if "fields" has a value not defined
  The field "fields" take as empty any value that not be some label fields

    When I send a GET request to "/labels/{label.id}" with the following parameters
      | fields | <Value> |
    Then I validate the response has status code 200
    And I validate the response contains the following data
      | id | {label.id} |

    Examples: Values taken as empty
      | Value           |
      | {empty}         |
      | !@#$%^&*()      |
      | any letter 1000 |
