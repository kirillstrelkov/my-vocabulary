Feature: Application should support different languages and language pairs

  Scenario: User should be change languge pair
    Given I am on main page
    And pending

  Scenario: User should be able to use application in English
    Given I am on main page
    And pending

  Scenario: User should be able to use application in Russian
    Given I am on main page
    And pending

  Scenario: Language combination should be saved between pages
    Given I am on main page
    Then I should see "English" option selected in "lang_code1"
    And I should see "Albanian" option selected in "lang_code2"
    When I click "Add word"
    Then I should see "English" option selected in "lang_code1"
    And I should see "Albanian" option selected in "lang_code2"
    When I click "Play"
    Then I should see "English" option selected in "lang_code1"
    And I should see "Albanian" option selected in "lang_code2"

  Scenario: Default language should be English
    Given I am on main page
    Then I should see "English" option selected in "lang_code1"
    And I should see "Albanian" option selected in "lang_code2"

  Scenario: Language pair is correct if locale is russian
    Given I am on main page
    Then I should see "Russian" option selected in "lang_code1"
    And I should see "Belorussian" option selected in "lang_code2"


  Scenario: Language pair should be preserved while navigating
    Given I am on main page
    And I select "English" from "lang_code1"
    And I select "Russian" from "lang_code2"
    When I click "Add word"
    Then I should see "English" option selected in "lang_code1"
    And I should see "Russian" option selected in "lang_code2"
