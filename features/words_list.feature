Feature: Words list
  Background:
    Given I am logged in as "Guest"
    Given the following words exist:
    | lang_code1 | lang_code2 | pos  | gender | text1 | text2  |
    |   en       |    ru      | noun |   ж    | dog   | собака |
    |   en       |    ru      | noun |   м    | dog   | пес    |
    |   de       |    ru      | noun |   ж    | Hund  | собака |
    |   de       |    ru      | noun |   м    | Hund  | пес    |

  Scenario: Guest user should not be able to delete words
    When I am on main page
    Then I should see "Words: 1" on page
    When I click "Destroy"
    And I accept alert
    When I refresh page
    Then I should see "Words: 1" on page

  Scenario: User should be able to delete word
    Given pending

  Scenario: User should see Russian-German words if Russian-German is selected
    Given pending

  Scenario: User should see German-English words if German-English is selected
    Given pending

  Scenario: User should see Russian-German words if Russian-German lang_pair is passed
    Given pending

  Scenario: User should see German-English words if German-English lang_pair is passed
    Given pending
