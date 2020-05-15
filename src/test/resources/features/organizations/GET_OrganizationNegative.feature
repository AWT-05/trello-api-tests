@negative
Feature: Organization Controller

  Background: Set authentication and create Organization
    Given I set authentication using API key and token
    And I have an organization created

  @deleteOrganization
  Scenario Outline: Get Organization with non existing ids
    When I send a GET request to "/organizations/<notFound>"
    Then I validate the response has status code 404
    Examples:
      | notFound                 |
      | 5ebcc6190d42c726291a47a9 |
      | ABCDEFABCDEFABCDEFABCDEF |

  @deleteOrganization
  Scenario Outline: Get Organization with incorrect id and special characters
    When I send a GET request to "/organizations/<invalid>"
    Then I validate the response has status code 400
    Examples:
      | invalid                  |
      | ~!@#$%^&*_+-=`!!@#$%^^&$ |
      | [][][][][()()()()(][][   |
      | ZGHJKLXVNMzghjklnm234567 |
