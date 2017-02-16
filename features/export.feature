@wip
Feature: User should be able to export csv file

  Scenario: Export to csv file
    Given I am on main page
    When pending
    When I click "Export words to CSV"
    And I select "export.csv" test file
    And I click "Select all"
    And I click "Export"
    Then I should see "words were saved successfully" on page
