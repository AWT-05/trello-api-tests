Feature: Organization Controller

  Background: Set authentication and create a organization
    Given I set authentication using API key and token
    And I have an organization created as "org"

  Scenario: Get an organization
    When I send a GET request to "/organizations/{org.id}"
