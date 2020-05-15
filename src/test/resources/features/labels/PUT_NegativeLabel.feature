@negative
Feature: Label Controller

  Background: authenticate user and set up a label
    Given I set authentication using API key and token

  @smoke
  Scenario: No gets a label with non-existent ids
  Valid id match to the following Pattern: ^[0-9a-fA-F]{32}$
  and we are validating that non-existent ids throw a 404 status code.

    When I send a PUT request to "/labels/000000000000000000000000" with the following json body
    """
      {
        "name" : "test",
        "color": "lime"
      }
    """
    Then I validate the response has status code 404
    And I validate the response contains the following text value
    """
    The requested resource was not found.
    """

  Scenario Outline: No gets a label with invalid ids/
  Valid id match to the following Pattern: ^[0-9a-fA-F]{32}$
  and we are validating that invalid ids throw a 400 status code.

    When I send a PUT request to "/labels/<Invalid id>" with the following json body
    """
      {
        "name" : "test",
        "color": "lime"
      }
    """
    Then I validate the response has status code 400
    And I validate the response contains the following text value
    """
    invalid id
    """

    Examples: Invalid ids
      | Invalid id                |
      | 5ebabeeb076f7c01g*!@#$*&  |
      | 5ebabeeb076f7c01876e92fA  |
      | 5ebabeeb076f7c01876e92f8a |
