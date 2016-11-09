Feature: Cards play
  Background:
    Given I am logged in as "Guest"

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

    Scenario: User should be able play with reversed languages
      Given the following words exist:
      | lang_code1 | lang_code2 | text1 | text2 |
      |   de       |    en      | hallo | hello |
      |   de       |    en      | machen| make  |
      |   de       |    en      | haben | have  |
      |   de       |    en      | muss  | must  |
      |   de       |    en      | tun   | do    |
      When I am on main page
      And I select "English" from "lang_code1"
      And I select "German" from "lang_code2"
      And I click "Play"
      When I choose correct answer
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

  Scenario: User should see message if number of words are less then 4
    Given the following words exist:
    | lang_code1 | lang_code2 | text1 | text2 |
    |   de       |    en      | hallo | hello |
    |   de       |    en      | hallo | hi    |
    |   de       |    en      | haben | have  |
    When I am on main page
    And I select "German" from "lang_code1"
    And I select "English" from "lang_code2"
    And I click "Play"
    Then I should see "Words: 3" on page
    Then I should see "Not enough words to play for this language pair, please add more words or choose another pair" on page

  Scenario: User should be able to skip and get -1
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
    When I click "Don't know"
    Then I should see "Score: 0" on page
    And I should see correct answer

  Scenario: User should correct words with direct and reversed languages
    Given the following words exist:
    | lang_code1 | lang_code2 | text1 | text2 |
    |   de       |    en      | hallo | hello |
    |   de       |    en      | machen| make  |
    |   de       |    en      | haben | have  |
    |   de       |    en      | muss  | must  |
    |   de       |    en      | tun   | do    |
    When I am on main page
    And I am on "/words/play?lang_pair=de-en"
    And I am playing with "muss"
    Then I should see "muss" in ".panel-heading"
    And I should see "must" in ".panel-body"
    When I am on "/words/play?lang_pair=en-de"
    And I am playing with "muss"
    Then I should see "must" in ".panel-heading"
    And I should see "muss" in ".panel-body"

  Scenario: User should correct words with direct with words with random languages
    Given the following words exist:
    | lang_code1 | lang_code2 | text1 | text2 |
    |   en       |    de      | make  | machen|
    |   de       |    en      | haben | have  |
    |   en       |    de      | must  | muss  |
    |   de       |    en      | tun   | do    |
    When I am on main page
    And I am on "/words/play?lang_pair=de-en"
    And I am playing with "make"
    Then I should see "machen" in ".panel-heading"
    And I should see "make" in ".panel-body"
    And I should see "have" in ".panel-body"
    And I should see "do" in ".panel-body"
    And I should see "must" in ".panel-body"
    When I am on "/words/play?lang_pair=en-de"
    And I am playing with "make"
    Then I should see "make" in ".panel-heading"
    And I should see "machen" in ".panel-body"
    And I should see "haben" in ".panel-body"
    And I should see "muss" in ".panel-body"
    And I should see "tun" in ".panel-body"
