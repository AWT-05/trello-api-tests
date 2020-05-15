@featureMulti @deleteBoard
Feature: List Controller

  Background: authenticate user and set up a board
    Given I set authentication using API key and token
    And I have a board created
    And I have a list created

  @negative
  Scenario: Get a List without id
    When I send a GET request to "/lists/{empty}"
    Then I validate the response has status code 404

  @negative
  Scenario Outline: Get a List with non-acceptable id
    When I send a GET request to "/lists/<value>"
    Then I validate the response has status code 400
    Examples:
      | value                            |
      | amIAcceptedNow2                  |
      | ()()123                          |
      | qwertyuiop09876lkjhgfdsa12345zxc |

  @negative
  Scenario Outline: Get a List with non-existent id
    When I send a GET request to "/lists/<value>"
    Then I validate the response has status code 404
    Examples:
      | value                    |
      | 000000000000ffffffffffff |
      | 5eba06ca7102332c34ce98fa |
