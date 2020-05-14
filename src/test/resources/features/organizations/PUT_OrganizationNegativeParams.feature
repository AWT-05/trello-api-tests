@negative
Feature: Organization Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have an organization created

  @deleteOrganization
  Scenario Outline: Update an Organization evaluating display name parameters
    When I send a PUT request to "/organizations/{organization.id}" with the following parameters
      | displayName | <Updated Name parameter> |
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | <Updated Name parameter> |
    Examples:
      | Updated Name parameter                     |
      | evaluating lower case                      |
      | EVALUATIN UPPERCASE                        |
      | evaluating especial characters ------????? |
      | evaluating especial characters []{}{}()]   |
      | evaluating especial characters @#$%^^&*(   |
      | evaluating CHARACTERS MIX 123!%@#&$**%     |

  @deleteOrganization
  Scenario Outline: Updated an Organization evaluating description parameter
    When I send a PUT request to "/organizations/{organization.id}" with the following parameters
      | displayName | New organization test |
      | desc        | <Updated Description> |
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test |
      | desc        | <Updated Description> |
    Examples:
      | Updated Description                        |
      | evaluating lower case                      |
      | EVALUATIN UPPERCASE                        |
      | evaluating especial characters ------????? |
      | evaluating especial characters []{}{}()]   |
      | evaluating especial characters @#$%^^&*(   |
      | evaluating CHARACTERS MIX 123!%@#&$**%     |

  @deleteOrganization
  Scenario Outline: Update an Organization evaluating website parameter
    When I send a PUT request to "/organizations/{organization.id}" with the following parameters
      | displayName | New organization test |
      | website     | <Updated Website>     |
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test    |
      | website     | http://<Updated Website> |
    Examples:
      | Updated Website                            |
      | fundacion-jala.org  format                 |
      | evaluating website format                  |
      | EVALUATIN UPPERCASE format                 |
      | evaluating especial characters ------????? |
      | evaluating especial characters []{}{}()]   |
      | evaluating especial characters @#$%^^&*(   |
      | evaluating CHARACTERS MIX 123!%@#&$**%     |

  @deleteOrganization
  Scenario Outline: Update an Organization evaluating unique parameter
    When I send a PUT request to "/organizations/{organization.id}" with the following parameters
      | name        | <Organization name>   |
    Then I validate the response has status code 400
    And I validate the response body should match with "organizations/orgErrorSchema.json" JSON schema
    And I validate the response contains the following data
      | message | Organization short name is invalid: only lowercase letters, underscores, and numbers are allowed |
      | error   | ERROR                                                                                            |
    Examples:
      | Organization name                          |
      | EVALUATIN UPPERCASE format                 |
      | evaluating especial characters ------????? |
      | evaluating especial characters []{}{}()]   |
      | evaluating especial characters @#$%^^&*(   |
      | evaluating CHARACTERS MIX 123!%@#&$**%     |
