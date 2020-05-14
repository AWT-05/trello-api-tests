Feature: List Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created
    And I have a list created

  @deleteBoard
  Scenario: Update a List created
    When I send a PUT request to "/lists/{list.id}" with the following parameters
      | name       | Ready for QA |
      | closed     | true         |
      | pos        | bottom       |
      | subscribed | true         |
    Then  I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {list.id}    |
      | pos     | 65536        |
      | name    | Ready for QA |
      | closed  | true         |
      | idBoard | {board.id}   |

  @deleteBoard
  Scenario: Archive (close) a List
    When I send a PUT request to "/lists/{list.id}/closed" with the following parameters
      | value | true |
    Then I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {list.id}   |
      | pos     | {list.pos}  |
      | name    | {list.name} |
      | closed  | true        |
      | idBoard | {board.id}  |

  @deleteBoard
  Scenario: Update a field on a List
    When I send a PUT request to "/lists/{list.id}/name" with the following parameters
      | value | Ready for QA |
    Then I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | id      | {list.id}     |
      | pos     | {list.pos}    |
      | name    | Ready for QA  |
      | closed  | {list.closed} |
      | idBoard | {board.id}    |
