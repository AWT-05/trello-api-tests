@negative
Feature: Organization Controller

  Background: Set authentication and create Organization
    Given I set authentication using API key and token
    And I have an organization created

  @deleteOrganization
  Scenario: Delete Organization without authentication
    Given I don't set authentication
    When I send a DELETE request to "/organizations/{organization.id}"
    Then I validate the response has status code 401
    #this step is necessary to clean the workspace
    And I set authentication using API key and token
