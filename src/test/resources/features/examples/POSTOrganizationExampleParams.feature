@functional
Feature: Organization Controller

  Background: Set authentication and create Organization
    Given I set authentication using API key and token

  @deleteOrganization
  Scenario: Create an Organization
    When I send a POST request to "/organizations" with the following parameters
      | displayName | New organization test                |
      | desc        | Description of new organization test |
      | website     | fundacion-jala.org                   |
    And I save response as "organization"
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200