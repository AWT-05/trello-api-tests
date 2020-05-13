Feature: Label Controller

  Background: authenticate user and set up a label
    Given I set authentication using API key and token
    # default board saved as "board"
    And I have a board created
    # default label saved as "label"
    And I have a label created

  @deleteLabel @deleteBoard
  Scenario: Gets a label created
    When I send a GET request to "/labels/{label.id}"
    Then I validate the response has status code 200
    And I validate the response body should match with "/labels/labelSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {label.id}    |
      | idBoard | {board.id}    |
      | name    | {label.name}  |
      | color   | {label.color} |

  @deleteLabel @deleteBoard
  Scenario Outline: Gets a label with all fields
  If we don't send "fields" value, the default is "all"

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

  @deleteLabel @deleteBoard
  Scenario Outline: Gets a label specifying the "fields" field
    When I send a GET request to "/labels/{label.id}" with the following parameters
      | fields | <Field> |

    Then I validate the response has status code 200
    And I validate the response contains the following data
      | id      | {label.id} |
      | <Field> | <Value>    |

    Examples: Field requested
      | Field   | Value         |
      | idBoard | {board.id}    |
      | name    | {label.name}  |
      | color   | {label.color} |

  @deleteLabel @deleteBoard
  Scenario Outline: Gets a label specifying the "fields" field as empty
  The field "fields" take as empty any value that not be some label fields

    When I send a GET request to "/labels/{label.id}" with the following parameters
      | fields | <Value> |

    Then I validate the response has status code 200
    And I validate the response contains the following data
      | id | {label.id} |

    Examples: Values taken as empty
      | Value   |
      | {empty} |
      | label   |
      | board   |
      | idLabel |
      | a       |
      | 1       |
