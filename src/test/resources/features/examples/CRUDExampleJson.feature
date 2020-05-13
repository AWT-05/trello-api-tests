@functional
Feature: Organization Controller

  Background: Set authentication and create Organization
    Given I set authentication using API key and token
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : "New organization test",
	    "desc" : "Description of updated organization test",
	    "website" : "fundacion-jala.org"
      }
      """
    And I save response as "organization"
    Then I validate the response has status code 200

  @deleteOrganization
  Scenario: Get Organization created
    When I send a GET request to "/organizations/{organization.id}"
    Then I validate the response has status code 200

  @deleteOrganization
  Scenario: Update Organization created
    When I send a PUT request to "/organizations/{organization.id}" with the following json body
      """
      {
	    "displayName" : "organization test updated",
	    "desc" : "Description of updated organization test"
      }
      """
    Then I validate the response has status code 200

  Scenario: Delete organization created
    When I send a DELETE request to "/organizations/{organization.id}"
    Then I validate the response has status code 200
