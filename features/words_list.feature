Feature: Words list
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

  Scenario: User should see updated table if language pair was changed
    Given pending
# TODO check alerts: close, success, warning, etc
