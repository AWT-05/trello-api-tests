@negative
Feature: Organization Controller

  Background: Set authentication
    Given I set authentication using API key and token

  @deleteOrganization
  Scenario Outline: Create an Organization with Json body and evaluating display name parameters
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : "<Display Name parameter>"
      }
      """
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | <Display Name parameter> |
    Examples:
      | Display Name parameter                 |
      | evaluating lower case                  |
      | EVALUATIN UPPERCASE                    |
      | evaluating especial characters`!@#$%   |
      | evaluating especial characters ()      |
      | evaluating especial characters __--??? |
      | evaluating CHARACTERS MIX 123!%@#&$**% |

  Scenario: Create an Organization using Json body with leading white spaces
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : " evaluating leading white spaces"
      }
      """
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 400
    And I validate the response body should match with "organizations/orgErrorSchema.json" JSON schema
    And I validate the response contains the following data
      | message | Display Name cannot begin or end with a space |
      | error   | ERROR                                         |

  Scenario: Create an Organization using Json body with trailing white spaces
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : "evaluating trailing white spaces "
      }
      """
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 400
    And I validate the response body should match with "organizations/orgErrorSchema.json" JSON schema
    And I validate the response contains the following data
      | message | Display Name cannot begin or end with a space |
      | error   | ERROR                                         |

  @deleteOrganization
  Scenario Outline: Create an Organization with json body evaluating description parameter
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : "New organization test",
	    "desc" : "<Description>"
      }
      """
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test |
      | desc        | <Description>         |
    Examples:
      | Description                                |
      | evaluating lower case                      |
      | EVALUATIN UPPERCASE                        |
      | evaluating especial characters ------????? |
      | evaluating especial characters []{}{}()]   |
      | evaluating especial characters @#$%^^&*(   |
      | evaluating CHARACTERS MIX 123!%@#&$**%     |

  @deleteOrganization
  Scenario Outline: Create an Organization with json body evaluating website parameter
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : "New organization test",
	    "website" : "<Website>"
      }
      """
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test |
      | website     | http://<Website>      |
    Examples:
      | Website                                    |
      | fundacion-jala.org  format                 |
      | evaluating website format                  |
      | EVALUATIN UPPERCASE format                 |
      | evaluating especial characters ------????? |
      | evaluating especial characters []{}{}()]   |
      | evaluating especial characters @#$%^^&*(   |
      | evaluating CHARACTERS MIX 123!%@#&$**%     |

  @deleteOrganization
  Scenario Outline: Create an Organization with json body evaluating unique parameter
    When I send a POST request to "/organizations" with the following json body
      """
      {
	    "displayName" : "New organization test",
	    "name" : "<Organization name>"
      }
      """
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgSchema.json" JSON schema
    Examples:
      | Organization name                          |
      | EVALUATIN UPPERCASE format                 |
      | evaluating especial characters ------????? |
      | evaluating especial characters []{}{}()]   |
      | evaluating especial characters @#$%^^&*(   |
      | evaluating CHARACTERS MIX 123!%@#&$**%     |
