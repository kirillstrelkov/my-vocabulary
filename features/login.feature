Feature: User should be able to login

  Scenario: User logins in with Facebook account
    Given I am on main page
    When I login with "Facebook" account
    And I should see "Successfully authenticated from Facebook account." within 5 seconds
    When I click "Logout"
    Then I should see "You need to sign in or sign up before continuing." within 5 seconds
    When I login with "Facebook" account
    And I should see "Successfully authenticated from Facebook account" within 5 seconds

  Scenario: User logins in with Vkontakte account
    Given I am on main page
    When I login with "Vkontakte" account
    And I should see "Successfully authenticated from Vkontakte account." on page
    When I click "Logout"
    Then I should see "You need to sign in or sign up before continuing." on page
    When I login with "Vkontakte" account
    And I should see "Successfully authenticated from Vkontakte account" on page

  Scenario: User logins in with Google account
    Given I am on main page
    When I login with "Google" account
    And I should see "Successfully authenticated from Google account." on page
    When I click "Logout"
    Then I should see "You need to sign in or sign up before continuing." on page
    When I login with "Google" account
    And I should see "Successfully authenticated from Google account" on page

  Scenario: User registers logs in then logs out and logs in
    Given I am on main page
    Then I should see "You need to sign in or sign up before continuing." on page
    When I click "Sign up"
    And I fill in "user_name" with "New user"
    And I fill in "user_email" with "name@gmail.com"
    And I fill in "user_password" with "123456"
    And I fill in "user_password_confirmation" with "123456"
    And I click "Sign up"
    Then I should see "New user" on page
    And I should see "Welcome! You have signed up successfully." on page
    When I click "Logout"
    Then I should see "You need to sign in or sign up before continuing." on page
    When I fill in "user_email" with "name@gmail.com"
    And I fill in "user_password" with "123456"
    And I click "Log in"
    Then I should see "New user" on page
    And I should see "Signed in successfully" on page
