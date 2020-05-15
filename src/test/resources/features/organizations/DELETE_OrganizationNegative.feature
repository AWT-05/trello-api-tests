@negative
Feature: Organization Controller

  Background: Set authentication and create Organization
    Given I set authentication using API key and token

  Scenario Outline: Delete organization with non existing id
    When I send a DELETE request to "/organizations/<notFound>"
    Then I validate the response has status code 404
    Examples:
      | notFound                 |
      | 5ebcc6190d42c726291a47a9 |
      | ABCDEFABCDEFABCDEFABCDEF |
      | ZGHJKLXVNMzghjklnm234567 |

  Scenario Outline: Delete organization with incorrect id
    When I send a DELETE request to "/organizations/<invalid>"
    Then I validate the response has status code 400
    Examples:
      | invalid                  |
      | ~!@#$%^&*_+-=`!!@#$%^^&$ |
      | [][][][][()()()()(][][   |
      | ZGHJKLXVNMzghjklnm234567 |
