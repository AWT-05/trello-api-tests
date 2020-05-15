@negative
Feature: Organization Controller

  Background: Do not Set authentication
    Given I don't set authentication

  Scenario: Create an Organization without authentication
    When I send a POST request to "/organizations" with the following parameters
      | displayName | organization test  |
      | desc        | Description        |
      | website     | fundacion-jala.org |
    Then I validate the response has status code 401

  Scenario: Create an Organization using json body without authentication
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : "organization test",
	    "desc" : "Description organization test",
	    "website" : "fundacion-jala.org"
      }
      """
    Then I validate the response has status code 401
