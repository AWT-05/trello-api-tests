@negative
Feature: Label Controller

  Background: authenticate user and set up a label
    Given I set authentication using API key and token

  Scenario: Try to delete a label sending an empty id

    When I send a DELETE request to "/labels/{empty}"
    Then I validate the response has status code 404
    And I validate the response contains the following text value
    """
    invalid id
    """

  Scenario: Try to delete a label with non-existent ids
  Valid id match to the following Pattern: ^[0-9a-fA-F]{32}$
  and we are validating that non-existent ids throw a 404 status code.

    When I send a DELETE request to "/labels/ffffffffffffffffffffffff"
    Then I validate the response has status code 404
    And I validate the response contains the following text value
    """
    The requested resource was not found.
    """

  @smoke
  Scenario Outline: Try to delete a label with invalid ids
  Valid id match to the following Pattern: ^[0-9a-fA-F]{32}$
  and we are validating that invalid ids throw a 400 status code.

    When I send a DELETE request to "/labels/<Invalid id>"
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
