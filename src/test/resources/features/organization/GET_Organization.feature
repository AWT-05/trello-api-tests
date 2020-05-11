Feature: Organization Controller

  Background: Set authentication and create a organization
    Given I set authentication using API key and token
    And I have an organization created
    And I have an card created
    And I have an list created
    And I have an borad created

  Scenario: Get an organization
    When I send a GET request to "/organizations/{org.id}"

