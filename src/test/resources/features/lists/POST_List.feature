Feature: List Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created

  @deleteBoard
  Scenario Outline: Create a List
    When I send a POST request to "/lists" with the following parameters
      | name    | Reviewed   |
      | pos     | <pos>      |
      | idBoard | {board.id} |
    Then  I validate the response has status code 200
#    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | name    | Reviewed   |
      | closed  | false      |
      | pos     | <expected> |
      | idBoard | {board.id} |
    Examples:
      | pos    | expected |
      | top    | 8192     |
      | bottom | 65536    |
      | 40000  | 40000    |
