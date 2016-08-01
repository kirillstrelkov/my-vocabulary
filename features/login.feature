Feature: User should be able to login

  Scenario: User logins in with Facebook account
    Given I am on main page
    When I login with "Vkontakte" account
    Then I should see "Logout" on page

  Scenario: User logins in with Vkontakte account
    Given I am on main page
    When I login with "Vkontakte" account
    Then I should see "Logout" on page
