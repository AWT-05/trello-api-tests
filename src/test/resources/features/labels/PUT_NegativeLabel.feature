Feature: Label Controller

  Background: authenticate user and set up a label
    Given I set authentication using API key and token

  Scenario Outline: No gets a label with non-existent ids
  Valid id match to the following Pattern: ^[0-9a-fA-F]{32}$
  and we are validating that non-existent ids throw a 404 status code.

    When I send a PUT request to "/labels/<Non existent>" with the following parameters
      | name  | test |
      | color | lime |
    Then I validate the response has status code 404
    And I validate the response contains the following value
    """
    The requested resource was not found.
    """

    Examples: Non-existent ids

      | Non existent             |
#      | {empty}                  | Cannot PUT /1/labels/?key={{API_KEY}}&token={{API_TOKEN}}&color=lime&name=test
      | 000000000000000000000000 |
      | aaaaaaaaaaaaaaaaaaaaaaaa |
      | 00000000000fffffffffffff |
      | 999999999999999999999999 |
      | ffffffffffffffffffffffff |
      | 00000000000000000000000f |
#      | 11111111111111111111111A |
#      | 00000000000000000000000000000000 |
#      | 0000000000000000000000000000000A |


  Scenario Outline: No gets a label with invalid ids/
  Valid id match to the following Pattern: ^[0-9a-fA-F]{32}$
  and we are validating that invalid ids throw a 400 status code.

    When I send a PUT request to "/labels/<Invalid id>" with the following parameters
      | name  | test |
      | color | lime |
    Then I validate the response has status code 400
    And I validate the response contains the following value
    """
    invalid id
    """

    Examples: Invalid ids

      | Invalid id                |
      | *                         |
      | +                         |
      | $                         |
      | @                         |
      | #                         |
      | a                         |
      | ...                       |
      | 00000000000000000000000   |
      | zzzzzzzzzzzzzzzzzzzzzzzz  |
      | 9999999999999999999999999 |

