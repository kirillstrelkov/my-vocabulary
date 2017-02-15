Feature: Application should support different languages and language pairs
  Background:
    Given I am logged in as "Guest"

  Scenario: User should be change languge pair from url
    Given I am on "/?lang_pair=de-ru"
    Then I should see "German" option selected in "lang_code1"
    And I should see "Russian" option selected in "lang_code2"

  Scenario: User should be able to use application in English
    Given I am on main page
    And pending

  Scenario: User should be able to use application in Russian
    Given I am on main page
    And pending

  Scenario: Language combination should be saved between pages
    Given I am on main page
    Then I should see "English" option selected in "lang_code1"
    And I should see "Czech" option selected in "lang_code2"
    When I click "Add word"
    Then I should see "English" option selected in "lang_code1"
    And I should see "Czech" option selected in "lang_code2"
    When I click "Play"
    Then I should see "English" option selected in "lang_code1"
    And I should see "Czech" option selected in "lang_code2"

  Scenario: Language combination should be changable using button
    Given I am on main page
    Then I should see "English" option selected in "lang_code1"
    And I should see "Czech" option selected in "lang_code2"
    When I click css element "#change_langs"
    Then I should see "Czech" option selected in "lang_code1"
    And I should see "English" option selected in "lang_code2"

  Scenario: Default language should be English
    Given I am on main page
    Then I should see "English" option selected in "lang_code1"
    And I should see "Czech" option selected in "lang_code2"

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

  Scenario: Second language should be selected if possible
    Given I am on main page
    And I select "English" from "lang_code1"
    And I select "Russian" from "lang_code2"
    Then I should see "English" option selected in "lang_code1"
    And I should see "Russian" option selected in "lang_code2"
    And I select "German" from "lang_code1"
    Then I should see "German" option selected in "lang_code1"
    And I should see "Russian" option selected in "lang_code2"

  Scenario: Language pair should be saved in /users/edit
    Given I am on main page
    And I select "English" from "lang_code1"
    And I select "Russian" from "lang_code2"
    Then I should see "English" option selected in "lang_code1"
    And I should see "Russian" option selected in "lang_code2"
    When I am on "/users/edit"
    Then I should see "English" option selected in "lang_code1"
    And I should see "Russian" option selected in "lang_code2"
