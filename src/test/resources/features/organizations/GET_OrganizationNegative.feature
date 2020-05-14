@negative
Feature: Organization Controller

  Background: Set authentication and create Organization
    Given I set authentication using API key and token
    And I have an organization created

  @deleteOrganization
  Scenario Outline: Get Organization with incorrect id
    When I send a GET request to "/organizations/<organization.id>"
    Then I validate the response has status code 404
    Examples:
      | organization.id          |
      | 5ebcc6190d42c726291a47a9 |
      | null                     |
      | 789789756756464658098900 |
      | d09d9gf0d09gf0d9fg09sd8d |
      | {empty}                  |
      |                          |

  @deleteOrganization
  Scenario Outline: Get Organization with incorrect id and special characters
    When I send a GET request to "/organizations/<organization.id>"
    Then I validate the response has status code 400
    Examples:
      | organization.id      |
      | $#*($#*$(*%#%#$*(#$  |
      | [][][][][()()()()(]  |
      | +++++++++=========== |
      | ________------------ |
      | ```````````````````` |
