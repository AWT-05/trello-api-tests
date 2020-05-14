@deleteBoard
Feature: List Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created

  @smoke
  Scenario Outline: Create a List
    When I send a POST request to "/lists" with the following json body
      """
      {
	    "name": "<name_value>",
	    "pos": "<pos_value>",
	    "idBoard": "{board.id}"
      }
      """
    Then  I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | name    | <name_expected> |
      | closed  | false           |
      | pos     | <pos_expected>  |
      | idBoard | {board.id}      |
    Examples:
      | pos_value | pos_expected | name_value       | name_expected    |
      | top       | 8192         | Reviewed         | Reviewed         |
      | bottom    | 65536        | With numbers 123 | With numbers 123 |
      | 40000     | 40000        | ----             | ----             |

  @functional
  Scenario: Create a List copy of another List
    Given I have a list created
    When I send a POST request to "/lists" with the following json body
      """
      {
	    "name": "Reviewed copy",
	    "idBoard": "{board.id}",
	    "idListSource": "{list.id}"
      }
      """
    Then  I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | name    | Reviewed copy |
      | closed  | false         |
      | idBoard | {board.id}    |
