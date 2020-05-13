@functional
Feature: Organization Controller

  Background: Set authentication
    Given I set authentication using API key and token

  @deleteOrganization
  Scenario: Create an Organization with json body
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : "New organization test",
	    "desc" : "Description of updated organization test",
	    "website" : "fundacion-jala.org"
      }
      """
    And I save response as "organization"
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
