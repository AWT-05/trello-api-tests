@negative
Feature: Organization Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have an organization created

  @deleteOrganization
  Scenario Outline: Update an Organization with json body evaluating display name parameters
    When I send a PUT request to "/organizations/{organization.id}" with the following json body
      """
        {
          "displayName" : "<Updated Name parameter>"
        }
      """
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | <Updated Name parameter> |
    Examples:
      | Updated Name parameter                   |
      | evaluating lower case                    |
      | EVALUATING UPPERCASE                     |
      | evaluating @#$%^^&*!%@#&$**%--?????      |
      | evaluating especial characters []{}{}()] |

  @deleteOrganization
  Scenario Outline: Updated an Organization with json body evaluating description parameter
    When I send a PUT request to "/organizations/{organization.id}" with the following json body
      """
        {
          "desc" : "<Updated Description>"
        }
      """
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test |
      | desc        | <Updated Description> |
    Examples:
      | Updated Description                      |
      | evaluating lower case                    |
      | EVALUATING UPPERCASE format              |
      | evaluating @#$%^^&*!%@#&$**%--?????      |
      | evaluating especial characters []{}{}()] |

  @deleteOrganization
  Scenario Outline: Update an Organization with json body evaluating website parameter
    When I send a PUT request to "/organizations/{organization.id}" with the following json body
      """
      {
	    "displayName" : "New organization test",
	    "website" : "<Updated Website>"
      }
      """
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test    |
      | website     | http://<Updated Website> |
    Examples:
      | Updated Website                          |
      | fundacion-jala.org  format               |
      | evaluating lower case format             |
      | EVALUATING UPPERCASE format              |
      | evaluating @#$%^^&*!%@#&$**%--?????      |
      | evaluating especial characters []{}{}()] |

  @deleteOrganization
  Scenario Outline: Update an Organization with json body evaluating unique parameter
    When I send a PUT request to "/organizations/{organization.id}" with the following json body
      """
      {
	    "name" : "<Organization name>"
      }
      """
    Then I validate the response has status code 400
    And I validate the response body should match with "organizations/orgErrorSchema.json" JSON schema
    And I validate the response contains the following data
      | message | Organization short name is invalid: only lowercase letters, underscores, and numbers are allowed |
      | error   | ERROR                                                                                            |
    Examples:
      | Organization name                        |
      | evaluating lower case format             |
      | EVALUATING UPPERCASE format              |
      | evaluating @#$%^^&*!%@#&$**%--?????      |
      | evaluating especial characters []{}{}()] |

  @deleteOrganization
  Scenario: Update an Organization using Json body with leading white spaces
    When I send a PUT request to "/organizations/{organization.id}" with the following json body
      """
      {
	    "displayName" : " updating leading white spaces"
      }
      """
    Then I validate the response has status code 400
    And I validate the response body should match with "organizations/orgErrorSchema.json" JSON schema
    And I validate the response contains the following data
      | message | Display Name cannot begin or end with a space |
      | error   | ERROR                                         |

  @deleteOrganization
  Scenario: Create an Organization using Json body with trailing white spaces
    When I send a PUT request to "/organizations/{organization.id}" with the following json body
      """
      {
	    "displayName" : "updating trailing white spaces "
      }
      """
    Then I validate the response has status code 400
    And I validate the response body should match with "organizations/orgErrorSchema.json" JSON schema
    And I validate the response contains the following data
      | message | Display Name cannot begin or end with a space |
      | error   | ERROR                                         |
