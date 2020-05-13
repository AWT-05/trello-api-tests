Feature: Label Controller

  Background: Set authentication
    Given I set authentication using API key and token
    And I have a board created
    And I have a label created

  @deleteLabel @deleteBoard
  Scenario: Update a Label created
    When I send a PUT request to "/labels/{label.id}" with the following parameters
      | name  | test |
      | color | lime |

