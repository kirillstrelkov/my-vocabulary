Feature: User should be able to import csv file

  Scenario: Imprt words from csv file
    Given I am on main page
    When pending
    When I click "Import words to CSV"
    And I select "import.csv" test file
    And I click "Import"
    Then I should see "words were imported successfully" on page
