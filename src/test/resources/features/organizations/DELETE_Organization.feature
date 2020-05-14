@functional
Feature: Organization Controller

  Background: Set authentication and create Organization
    Given I set authentication using API key and token
    And I have an organization created

  Scenario: Delete organization
    When I send a DELETE request to "/organizations/{organization.id}"
    Then I validate the response has status code 200

  Scenario: Delete organization using name as path
    When I send a DELETE request to "/organizations/{organization.name}"
    Then I validate the response has status code 200
