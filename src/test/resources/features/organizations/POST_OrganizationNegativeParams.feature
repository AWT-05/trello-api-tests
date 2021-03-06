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
    And I validate the response body should match with "organizations/orgSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | <Display Name parameter> |
    Examples:
      | Display Name parameter                   |
      | evaluating lower case                    |
      | EVALUATING UPPERCASE format              |
      | evaluating @#$%^^&*!%@#&$**%--?????      |
      | evaluating especial characters []{}{}()] |

  @deleteOrganization
  Scenario Outline: Create an Organization evaluating description parameter
    When I send a POST request to "/organizations" with the following parameters
      | displayName | New organization test |
      | desc        | <Description>         |
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test |
      | desc        | <Description>         |
    Examples:
      | Description                              |
      | evaluating lower case                    |
      | EVALUATING UPPERCASE format              |
      | evaluating @#$%^^&*!%@#&$**%--?????      |
      | evaluating especial characters []{}{}()] |

  @deleteOrganization
  Scenario Outline: Create an Organization evaluating website parameter
    When I send a POST request to "/organizations" with the following parameters
      | displayName | New organization test |
      | website     | <Website>             |
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test |
      | website     | http://<Website>      |
    Examples:
      | Website                                  |
      | fundacion-jala.org  format               |
      | evaluating lowercase format              |
      | EVALUATING UPPERCASE format              |
      | evaluating @#$%^^&*!%@#&$**%--?????      |
      | evaluating especial characters []{}{}()] |

  @deleteOrganization
  Scenario Outline: Create an Organization evaluating unique parameter
    When I send a POST request to "/organizations" with the following parameters
      | displayName | New organization test |
      | name        | <Organization name>   |
    And I save the id value to clean "organization" workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgSchema.json" JSON schema
    Examples:
      | Organization name                        |
      | evaluating lowercase format              |
      | EVALUATING UPPERCASE format              |
      | evaluating @#$%^^&*!%@#&$**%--?????      |
      | evaluating especial characters []{}{}()] |
