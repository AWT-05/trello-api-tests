@functional
Feature: Organization Controller

  Background: Set authentication and create Organization
    Given I set authentication using API key and token
    And I have an organization created

  @deleteOrganization
  Scenario: Get Organization
    When I send a GET request to "/organizations/{organization.id}"
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test |

  @deleteOrganization
  Scenario: Get Organization using name as path
    When I send a GET request to "/organizations/{organization.name}"
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test |
