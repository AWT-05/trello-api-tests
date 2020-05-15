@functional
Feature: Organization Controller

  Background: Set authentication and create Organization
    Given I set authentication using API key and token
    And I have an organization created

  @deleteOrganization
  Scenario: Update required parameters in the Organization
    When I send a PUT request to "/organizations/{organization.id}" with the following parameters
      | displayName | organization test updated |
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | organization test updated |

  @deleteOrganization
  Scenario: Update optional parameters in the Organization
    When I send a PUT request to "/organizations/{organization.id}" with the following parameters
      | desc    | Description of new organization test |
      | website | fundacion-jala.org                   |
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test                |
      | desc        | Description of new organization test |
      | website     | http://fundacion-jala.org            |

  @deleteOrganization
  Scenario: Update unique parameter in the Organization
    When I send a PUT request to "/organizations/{organization.id}" with the following parameters
      | name | unique_organization_test_updated23 |
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test              |
      | name        | unique_organization_test_updated23 |

  @deleteOrganization
  Scenario: Update all allowed parameters in the Organization
    When I send a PUT request to "/organizations/{organization.id}" with the following parameters
      | displayName | organization test updated            |
      | name        | uniqu_org_test_updated23             |
      | desc        | Description of new organization test |
      | website     | fundacion-jala.org                   |
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | organization test updated            |
      | name        | uniqu_org_test_updated23             |
      | desc        | Description of new organization test |
      | website     | http://fundacion-jala.org            |

  @deleteOrganization
  Scenario: Update required parameters in the Organization using name as path parameter
    When I send a PUT request to "/organizations/{organization.name}" with the following parameters
      | displayName | organization test updated |
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | organization test updated |

  @deleteOrganization
  Scenario: Update optional parameters in the Organization using name as path parameter
    When I send a PUT request to "/organizations/{organization.name}" with the following parameters
      | desc    | Description of new organization test |
      | website | fundacion-jala.org                   |
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test                |
      | desc        | Description of new organization test |
      | website     | http://fundacion-jala.org            |

  @deleteOrganization
  Scenario: Update unique parameter in the Organization using name as path parameter
    When I send a PUT request to "/organizations/{organization.name}" with the following parameters
      | name | unique_organization_test_updated23 |
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | New organization test              |
      | name        | unique_organization_test_updated23 |

  @deleteOrganization @skipScenario
  Scenario: Update all allowed parameters in the Organization using name as path parameter
    When I send a PUT request to "/organizations/{organization.name}" with the following parameters
      | displayName | organization test updated            |
      | name        | unique_organization_updated23        |
      | desc        | Description of new organization test |
      | website     | fundacion-jala.org                   |
    Then I validate the response has status code 200
    And I validate the response body should match with "organizations/orgGetSchema.json" JSON schema
    And I validate the response contains the following data
      | displayName | organization test updated            |
      | name        | unique_organization_updated23        |
      | desc        | Description of new organization test |
      | website     | http://fundacion-jala.org            |
