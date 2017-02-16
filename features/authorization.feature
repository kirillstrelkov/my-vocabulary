@wip
Feature: User should be able to add new word
  Background:
    Given I am logged in as "Guest"

  Scenario: Guest user should not be able to delete words
    Given the following words exist:
    | lang_code1 | lang_code2 | text1 | text2 |
    |   de       |    en      | hallo | hello |
    When I am on main page
    Then I should see "Words: 1" on page
    When I click "Destroy"
    And I accept alert
    When I refresh page
    Then I should see "Words: 1" on page

  Scenario: Guest user should not be able to edit settings
    Given pending
