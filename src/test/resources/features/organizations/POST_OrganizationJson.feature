@functional
Feature: Organization Controller

  Background: Set authentication
    Given I set authentication using API key and token

  @deleteOrganization
  Scenario: Create an Organization using Json body with required parameters
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : "New organization test"
      }
      """
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test |

  @deleteOrganization
  Scenario: Create an Organization using Json body with optional parameters
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : "New organization test",
	    "desc" : "Description of new organization test",
	    "website" : "fundacion-jala.org"
      }
      """
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test                |
      | desc        | Description of new organization test |
      | website     | http://fundacion-jala.org            |

  @deleteOrganization
  Scenario: Create an Organization using Json body with unique parameter
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : "New organization test",
	    "name" : "new_organization_test_unique271"
      }
      """
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test           |
      | name        | new_organization_test_unique271 |

  @deleteOrganization
  Scenario: Create an Organization using Json body with all allowed parameters
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : "New organization test",
	    "name" : "organization_tests_unique23",
	    "desc" : "Description of new organization test",
	    "website" : "fundacion-jala.org"
      }
      """
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test                |
      | name        | organization_tests_unique23          |
      | desc        | Description of new organization test |
      | website     | http://fundacion-jala.org            |

  @deleteOrganization
  Scenario: Create an Organization using Json body with unique parameter and min length
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : "New organization test",
	    "name" : "y9b"
      }
      """
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test |
      | name        | y9b                   |
