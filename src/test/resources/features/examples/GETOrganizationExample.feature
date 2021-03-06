Feature: Organization Controller

  Background: Set authentication and create a organization
    Given I set authentication using API key and token
    And I have an organization created

  @deleteOrganization
  Scenario: Get an organization
    When I send a GET request to "/organizations/{organization.id}"
