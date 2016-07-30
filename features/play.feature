Feature: Cards play

  Scenario: User should not be able to play there is not enough words
    Given I am on main page
    When I click "Play"
    Then I should see "<string>" on page
    And pending

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
