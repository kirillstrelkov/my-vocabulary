Feature: Cards play

  Scenario: User should be able to get +1 score for correct result
    Given the following words exist:
    | lang_code1 | lang_code2 | text1 | text2 |
    |   de       |    en      | hallo | hello |
    |   de       |    en      | hallo | hi    |
    |   de       |    en      | haben | have  |
    |   de       |    en      | muss  | must  |
    |   de       |    en      | tun   | do    |
    When I am on main page
    And I click "Play"
    Then I should see "Words: 5" on page
    Then I should see "Score: 0" on page
    When I choose correct answer
    Then I should see "Score: 1" on page

  Scenario: User should be able to get -1 score for incorrect result
    Given the following words exist:
    | lang_code1 | lang_code2 | text1 | text2 |
    |   de       |    en      | hallo | hello |
    |   de       |    en      | hallo | hi    |
    |   de       |    en      | haben | have  |
    |   de       |    en      | muss  | must  |
    |   de       |    en      | tun   | do    |
    When I am on "/words/play" page
    Then I should see "Score: 0" on page
    When I choose incorrect answer
    Then I should see "Score: -1" on page

  Scenario: User should see message if number of words are less then 5
    Given the following words exist:
    | lang_code1 | lang_code2 | text1 | text2 |
    |   de       |    en      | hallo | hello |
    |   de       |    en      | hallo | hi    |
    |   de       |    en      | haben | have  |
    |   de       |    en      | muss  | must  |
    When I am on "/words/play" page
    Then I should see "Words: 4" on page
    Then I should see "Not enough words to play, please add more words" on page

#  Scenario: User should be able to play with cards
#    Given I am on main page
#    When I click "Add word"
#    When I fill in "q" with "hallo"
#    And I select "German" from "lang_code1"
#    And I select "English" from "lang_code2"
#    And I click "Get translations"
#    Then I should see "hello" on page
#    When I click "Add word"
#    And I am on main page
#    Then I should see "hello" on page
#    And I should see "hi" on page
#    And I should see "Hallo" on page
