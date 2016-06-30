Feature: Working with word and translation

  Scenario: User should be able to add word with new translation
    Given I am on main page
    When I click "Add word"
    When I fill in "word_text" with "hallo"
    And I select "German" from "word_lang_from"
    And I select "English" from "word_lang_to"
    And I click "Get translations"
    Then I should see "hello"
    When I click "Add word"
    And I am on main page
    Then I should see "hallo"

  Scenario Outline: User should be able to choose several languages and translate words
    Given I am on main page
    When I click "Add word"
    When I fill in "new_word" with "hallo"
    And I select "German" from "lang_from"
    And I select "English" from "lang_to"
    And I click "Get translations"
    Then I should see "hello"

    Examples:
      | from_lang | to_lang | orig_text | trans_text |
      | German    | English | hallo     | hello      |
      | German    | Russian | hallo     | привет     |
      | English   | Russian | hello     | привет     |