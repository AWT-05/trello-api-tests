@negative
Feature: Organization Controller

  Background: Set authentication
    Given I set authentication using API key and token

  @deleteOrganization
  Scenario Outline: Create an Organization evaluating display name parameters
    When I send a POST request to "/organizations" with the following parameters
      | displayName | <Display Name parameter> |
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/organizationSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | <Display Name parameter> |
    Examples:
      | Display Name parameter                     |
      | evaluating lower case                      |
      | EVALUATIN UPPERCASE                        |
      | evaluating especial characters ------????? |
      | evaluating especial characters []{}{}()]   |
      | evaluating especial characters @#$%^^&*(   |
      | evaluating CHARACTERS MIX 123!%@#&$**%     |

  @deleteOrganization
  Scenario Outline: Create an Organization evaluating description parameter
    When I send a POST request to "/organizations" with the following parameters
      | displayName | New organization test |
      | desc        | <Description>         |
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/organizationSchema.json" JSON schema
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
  Scenario Outline: Create an Organization evaluating website parameter
    When I send a POST request to "/organizations" with the following parameters
      | displayName | New organization test |
      | website     | <Website>             |
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/organizationSchema.json" JSON schema
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
  Scenario Outline: Create an Organization evaluating unique parameter
    When I send a POST request to "/organizations" with the following parameters
      | displayName | New organization test |
      | name        | <Organization name>   |
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/organizationSchema.json" JSON schema
    Examples:
      | Organization name                          |
      | EVALUATIN UPPERCASE format                 |
      | evaluating especial characters ------????? |
      | evaluating especial characters []{}{}()]   |
      | evaluating especial characters @#$%^^&*(   |
      | evaluating CHARACTERS MIX 123!%@#&$**%     |
