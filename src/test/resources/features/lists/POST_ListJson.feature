@deleteBoard
Feature: List Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created

  @smoke @functional
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
      | pos_value | pos_expected | name_value                            | name_expected                         |
      | top       | 8192         | Reviewed 2                            | Reviewed 2                            |
      | bottom    | 65536        | With numbers 123456789                | With numbers 123456789                |
      | 40000     | 40000        | With special chars <>!#$%&/()=[]{}*+- | With special chars <>!#$%&/()=[]{}*+- |

  @functional
  Scenario: Create a List copy of another List
    Given I have a list created
    When I send a POST request to "/lists" with the following json body
      """
      {
	    "name": "Reviewed copy json",
	    "idBoard": "{board.id}",
	    "idListSource": "{list.id}"
      }
      """
    Then  I validate the response has status code 200
    And I validate the response body should match with "/lists/listSchema.json" JSON schema
    And I validate the response contains the following data
      | name    | Reviewed copy json |
      | closed  | false              |
      | idBoard | {board.id}         |
