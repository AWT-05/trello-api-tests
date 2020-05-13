Feature: Label Controller

  Background: authenticate user and set up a label
    Given I set authentication using API key and token

  Scenario Outline: Get a label with non-existent ids
  Valid id match to the following Pattern: ^[0-9a-fA-F]{32}$
  and we are trying valid non-existent ids.

    When I send a GET request to "/labels/<Non existent>"
    Then I validate the response has status code 404
    And I validate the response contains the following value
    """
    The requested resource was not found.
    """

    Examples: Get a label with non-existent ids

      | Non existent             |
      | 000000000000000000000000 |
      | aaaaaaaaaaaaaaaaaaaaaaaa |
      | 00000000000fffffffffffff |
      | 999999999999999999999999 |
      | ffffffffffffffffffffffff |
      | 00000000000000000000000f |
