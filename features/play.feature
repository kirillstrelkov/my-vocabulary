Feature: Cards play

  Scenario: User should be able to get +1 score for correct result
    Given the following words exist:
    | lang_code1 | lang_code2 | text1 | text2 |
    |   de       |    en      | hallo | hello |
    |   de       |    en      | machen| make  |
    |   de       |    en      | haben | have  |
    |   de       |    en      | muss  | must  |
    |   de       |    en      | tun   | do    |
    When I am on main page
    And I select "German" from "lang_code1"
    And I select "English" from "lang_code2"
    And I click "Play"
    Then I should see "Words: 5" on page
    Then I should see "Score: 0" on page
    When I choose correct answer
    Then I should see "Score: 1" on page
    And I should see correct answer

  Scenario: User should be able to get -1 score for incorrect result
    Given the following words exist:
    | lang_code1 | lang_code2 | text1 | text2 |
    |   de       |    en      | hallo | hello |
    |   de       |    en      | machen| make  |
    |   de       |    en      | haben | have  |
    |   de       |    en      | müssen| must  |
    |   de       |    en      | tun   | do    |
    When I am on main page
    And I select "German" from "lang_code1"
    And I select "English" from "lang_code2"
    And I click "Play"
    Then I should see "Score: 0" on page
    When I choose incorrect answer
    Then I should see "Score: -1" on page
    And I should see incorrect answer
    And I should see correct answer

  Scenario: User should see message if number of words are less then 5
    Given the following words exist:
    | lang_code1 | lang_code2 | text1 | text2 |
    |   de       |    en      | hallo | hello |
    |   de       |    en      | hallo | hi    |
    |   de       |    en      | haben | have  |
    |   de       |    en      | muss  | must  |
    When I am on main page
    And I select "German" from "lang_code1"
    And I select "English" from "lang_code2"
    And I click "Play"
    Then I should see "Words: 4" on page
    Then I should see "Not enough words to play for this language pair, please add more words or choose another pair" on page
