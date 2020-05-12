Feature: Organization Controller

  Background: Set authentication
    Given I set authentication using API key and token


  Scenario: Create an organization
    When I send a POST request to "/organizations" with the following parameters
      | displayName | API_testing |


  Scenario: Get an organization
    When I send a GET request to "/organizations/{org.id}"


  Scenario: Update an organization
    When I send a PUT request to "/organizations/{org.id}" with the following parameters
      | displayName | Name Updated |
      | desc        | Only MOI     |


  Scenario: Delete an organization
    When I send a DELETE request to "/organizations/{org.id}"
