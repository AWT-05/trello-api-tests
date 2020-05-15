@negative
Feature: Organization Controller

  Background: Set authentication and create Organization
    Given I set authentication using API key and token
    And I have an organization created

  @deleteOrganization
  Scenario: Update Organization without authentication
    Given I don't set authentication
    When I send a PUT request to "/organizations/{organization.id}" with the following parameters
      | displayName | organization test updated            |
      | desc        | Description of new organization test |
      | website     | fundacion-jala.org                   |
    Then I validate the response has status code 401
    #this step is necessary to clean the workspace
    And I set authentication using API key and token

  @deleteOrganization
  Scenario: Update Organization using json body without authentication
    Given I don't set authentication
    When I send a PUT request to "/organizations/{organization.id}" with the following json body
      """
      {
	    "displayName" : "organization test updated",
	    "desc" : "Description of updated organization test",
	    "website" : "fundacion-jala.org"
      }
      """
    Then I validate the response has status code 401
    #this step is necessary to clean the workspace
    And I set authentication using API key and token
