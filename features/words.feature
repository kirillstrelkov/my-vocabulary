Feature: Working with word and translation

  Scenario: User should be able to add word with new translation
    Given I am on main page
    When I click "Add word"
    When I fill in "q" with "hallo"
    And I select "German" from "lang_code1"
    And I select "English" from "lang_code2"
    And I click "Get translations"
    Then I should see "hello" on page
    When I click "Add word"
    And I am on main page
    Then I should see "hello" on page
    And I should see "hi" on page
    And I should see "Hallo" on page

  Scenario Outline: User should be able to choose several languages and translate words
    Given I am on main page
    When I click "Add word"
    When I fill in "q" with "<orig_text>"
    And I select "<from_lang>" from "lang_code1"
    And I select "<to_lang>" from "lang_code2"
    And I click "Get translations"
    Then I should see "<trans_text>" on page

    Examples:
      | from_lang | to_lang | orig_text | trans_text |
      | German    | English | hallo     | hello      |
      | German    | Russian | tun       | делать     |
      | English   | Russian | hello     | привет     |

  Scenario: User should be able to delete word
    Given I am on main page

  Scenario: User should be able to search world with parameter in link
    Given I am on main page

  Scenario: User should be able navigate back to main page
    Given I am on main page
    When I click "Add word"
    And I click "Back"
    Then I should be on "/words"

  Scenario: Default language should be based on locale language
    Given I am on main page
    Then I should see "English" option selected in "lang_code1"
    Then I should see "English" option selected in "lang_code2"

  Scenario: Language combination should be save between pages
    Given I am on main page

  Scenario: User should receive and error if translates from unsupported language pair
    Given I am on main page
    When I click "Add word"
    When I fill in "q" with "hello"
    And I select "English" from "lang_code1"
    And I select "Belarusia" from "lang_code2"
    And I click "Get translations"
    Then I should see "The specified language is not supported" on page

  Scenario: User should be able to select language pairs
    Given I am on main page


# TODO check alerts: close, success, warning, etc