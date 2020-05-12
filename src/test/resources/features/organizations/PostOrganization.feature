@functional
Feature: Organization Controller

  Background: Set authentication
    Given I set authentication using API key and token

  @deleteOrganization
  Scenario: Create a Organization
    When I send a POST request to "/organizations" with the following parameters
      | displayName | New organization test                |
      | desc        | Description of new organization test |
      | website     | fundacion-jala.org                   |
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/organizationSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test                |
      | desc        | Description of new organization test |
      | website     | http://fundacion-jala.org            |
