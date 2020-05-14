@negative @deleteLabel @deleteBoard
Feature: Test POST, GET, PUT and DELETE without authorization

  Background: Set initial state and authentication
    Given I set authentication using API key and token
    * I have a board created
    * I have a label created
    And I set authentication using only a Token


  Scenario: Try to create a label with only a Token

    When I send a POST request to "/labels" with the following json body
    """
      {
        "name" : "authentication",
        "color" : "sky",
        "idBoard": "{board.id}"
      }
    """
    Then I validate the response has status code 401
    And I validate the response contains the following value
    """
    invalid key
    """

  Scenario: Try to get a label with only a Token

    When I send a GET request to "/labels/{label.id}"
    Then I validate the response has status code 401
    And I validate the response contains the following value
    """
    unauthorized permission requested
    """

  Scenario: Try to update a label with only a Token

    When I send a PUT request to "/labels/{label.id}" with the following json body
    """
      {
        "name" : "test",
        "color": "lime"
      }
    """
    Then I validate the response has status code 401
    And I validate the response contains the following value
    """
    invalid key
    """


  Scenario: Try to delete a label with only a Token

    When I send a DELETE request to "/labels/{label.id}"
    Then I validate the response has status code 401
    And I validate the response contains the following value
    """
    invalid key
    """