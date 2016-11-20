Feature: Word should have gender
  Background:
    Given I am logged in as "Guest"
    And the following words exist:
    | lang_code1 | lang_code2 | pos  | text1      | text1_gender | text2    | text2_gender |
    |   de       |    ru      | noun | Hund       |       m      |  собака  |   ж          |
    |   de       |    ru      | noun | Katze      |       f      |  кошка   |   ж          |
    |   de       |    ru      | noun | Pferd      |       n      |  лошадь  |   ж          |
    |   de       |    ru      | noun | Schildkröte|       f      |  черепаха|   ж          |
    |   de       |    ru      | noun | Vogel      |       m      |  птица   |   ж          |

  Scenario: Gender should be visible on words page
    When I am on "/words/play?lang_pair=de-ru"
    And I am playing with "Hund"
    Then I should see "m" on page
    And I should see "ж" on page
    And I should see "собака" on page
    When I am on "/words/play?lang_pair=ru-de"
    And I am playing with "Hund"
    Then I should see "m" on page
    And I should see "ж" on page
    And I should see "der Hund" on page

  Scenario: Gender should be visible on show page
    When I am on "/words/1"
    Then I should see "m" on page
    And I should see "ж" on page
    And I should see "Hund" on page

  Scenario: Gender should be visible in translations
    Given I am on main page
    When I click "Add word"
    When I fill in "q" with "Hund"
    And I select "German" from "lang_code1"
    And I select "Russian" from "lang_code2"
    And I click "Get translations"
    Then I should see "Hund" on page
    And I should see "m" on page
    And I should see "ж" on page

  Scenario: Gender should be visible in translations
    Given I am on main page
    And there are no words in database
    When I click "Add word"
    When I select "German" from "lang_code1"
    And I select "Russian" from "lang_code2"
    And I fill in "q" with "Maus"
    And I click "Get translations"
    Then I should see "мышь" on page
    And I choose 1st translation
    And I click "Add words"
    When I click "My vocabulary"
    Then I should see "мышь" on page
    And I should see "Maus" on page
    And I should see "ж" on page

  Scenario: Gender should be visible on play page
    Given I am on main page
    And I am on "/words/play?lang_pair=de-ru"
    And I am playing with "Hund"
    Then I should see "Hund" on page
    And I should see "der" on page
    And I should see "ж" on page

  Scenario: Gender should be visible on play page
    Given I am on main page
    And I am on "/words/play?lang_pair=ru-de"
    And I am playing with "Hund"
    Then I should see "собака" on page
    And I should see "der Hund" on page
