Feature: User should be able to add new word
  Background:
    Given I am logged in as "Guest"

  Scenario: User should be able navigate back to main page
    Given I am on main page
    When I click "Add word"
    And I click "My vocabulary"
    Then I should be on "/words"

  Scenario Outline: User should be able to choose several languages and translate words
    Given I am on main page
    When I click "Add word"
    When I fill in "q" with "<orig_text>"
    And I select "<from_lang>" from "lang_code1"
    And I select "<to_lang>" from "lang_code2"
    And I click "Get translations"
    Then I should see "<trans_text>" on page
    And I should see "<gender>" on page

    Examples:
      | from_lang | to_lang | orig_text | trans_text  | gender |
      | German    | English | hallo     | hello       |        |
      | German    | Russian | tun       | делать      |        |
      | English   | Russian | hello     | привет      |        |
      | English   | Russian | hello     | приветствие |   ср   |

  Scenario: User should be able to add word with new translation
    Given I am on main page
    When I click "Add word"
    When I fill in "q" with "hallo"
    And I select "German" from "lang_code1"
    And I select "English" from "lang_code2"
    And I click "Get translations"
    Then I should see "hello" on page
    When I choose 1st translation
    When I choose 2nd translation
    And I click "Add words"
    Then I should see "was added successfully" on page
    And I should see "Words: 2" on page
    And I should see "hello" on page
    And I should see "hi" on page
    And I should see "Hallo" on page

    Scenario: User should see one success message if tries to add word second time
      Given I am on main page
      When I click "Add word"
      And I select "English" from "lang_code1"
      And I select "Russian" from "lang_code2"
      When I fill in "q" with "tal"
      And I click "Get translations"
      Then I should see "таль" on page
      When I choose 1st translation
      When I click "Add words"
      Then I should see "was added successfully" on page
      When I click "Add words"
      Then I should not see "was added successfully" on page

    Scenario: User should see message if translation not found
      Given I am on main page
      When I click "Add word"
      And I select "English" from "lang_code1"
      And I select "Russian" from "lang_code2"
      When I fill in "q" with "sdfsdf"
      And I click "Get translations"
      Then I should see "No translations were found" on page

    Scenario: User should see message if tries to add word without selecting one of them
      Given I am on main page
      When I click "Add word"
      And I select "English" from "lang_code1"
      And I select "Russian" from "lang_code2"
      And I click "Add words"
      Then I should see "No translations were selected" on page

  Scenario: User should be able to seach for translation with ENTER
    Given I am on main page
    When I click "Add word"
    And I select "German" from "lang_code1"
    And I select "English" from "lang_code2"
    And I fill in "q" with "hallo"
    And I hit ENTER in "q"
    Then I should see "hello" on page

  @wip
  Scenario: User should be able to search with parameter in url as query
    Given I select "German" from "lang_code1"
    And I select "English" from "lang_code2"
    When I am on "/words/new?q=hallo"
    Then I should see "hello" on page

  @wip
  Scenario: User should be able to search with parameter in url as hash
    Given I select "German" from "lang_code1"
    And I select "English" from "lang_code2"
    When I am on "/words/new#q=hallo"
    Then I should see "hello" on page

  Scenario: User should be able to select correct language pairs
    Given I am on main page
    And pending

  Scenario: User should see notification if no translations found
    Given I am on main page
    And pending

  Scenario: User should be able to remove search word
    Given I am on main page
    When I click "Add word"
    And I fill in "q" with "word"
    Then I should see "word" in search field
    When I click css element "#clear_search"
    Then I should see "" in search field
