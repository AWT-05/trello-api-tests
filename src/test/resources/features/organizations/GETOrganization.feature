@functional
Feature: Organization Controller

  Background: Set authentication and create Organization
    Given I set authentication using API key and token
    When I send a POST request to "/organizations" with the following parameters
      | displayName | New organization test                |
      | desc        | Description of new organization test |
      | website     | fundacion-jala.org                   |
    And I save response as "organization"
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200

  @deleteOrganization
  Scenario: Get Organization created
    When I send a GET request to "/organizations/{organization.id}"
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/organizationGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test                |
      | desc        | Description of new organization test |
      | website     | http://fundacion-jala.org            |