Feature: Organization Controller

  Background: Set authentication
    Given I set authentication using API key and token

  Scenario: Create an organization
    When I send a POST request to "/organizations" with the following parameters
      | displayName | API_testing |


  Scenario: Get an organization
    When I send a GET request to "/organizations/5eb8955b28e74230cc87d14f"

