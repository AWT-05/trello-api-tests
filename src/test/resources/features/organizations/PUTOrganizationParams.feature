@functional
Feature: Organization Controller

  Background: Set authentication and create Organization
    Given I set authentication using API key and token
    And I have an organization created

  @deleteOrganization
  Scenario: Update display name Organization created
    When I send a PUT request to "/organizations/{organization.id}" with the following parameters
      | displayName | organization test updated            |
      | desc        | Description of new organization test |
      | website     | fundacion-jala.org                   |
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/organizationGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | organization test updated            |
      | desc        | Description of new organization test |
      | website     | http://fundacion-jala.org            |
