# frozen_string_literal: true

Given(/^I am logged in as "([^"]*)"$/) do |username|
  create_guest if username.downcase == 'guest'
  visit('/users/sign_in')
  click_button('Try it')
  assert_text('Logout')
end

Given(/^there are no words in database$/) do
  Word.destroy_all
end

When(/^I am playing with "([^"]*)"$/) do |value|
  visit("/words/play?text1=#{value}")
end

Given(/^the following words exist:$/) do |table|
  data = table.raw
  header = data.first
  Word.destroy_all
  user_id = create_guest.id
  data[1..-1].each do |row|
    hash = Hash[header.zip(row)]
    hash[:user_id] = user_id
    FactoryGirl.create(:word, hash)
  end
end

When(/^I choose (\w+) translation$/) do |number|
  number = number[/\d+/].to_i - 1
  all(:css, '.translation')[number].click
end

When(/^I select "([^"]*)" test file$/) do |_arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I login with "([^"]*)" account$/) do |provider|
  provider.downcase!
  if host_redirected? { click_link_or_button("Sign in with #{provider.capitalize}") }
    username = nil
    password = nil
    case provider
    when 'facebook'
      within('#loginform') do
        username = ENV['FACEBOOK_TEST_USERNAME']
        password = ENV['FACEBOOK_TEST_PASSWORD']
      end
    when 'google'
      username = ENV['GOOGLE_TEST_USERNAME']
      password = ENV['GOOGLE_TEST_PASSWORD']
    when 'vkontakte'
      username = ENV['VKONTAKTE_TEST_USERNAME']
      password = ENV['VKONTAKTE_TEST_PASSWORD']
    end
    login_with(provider, username, password)
  end
end

When(/^I choose correct answer$/) do
  correct_word_id = find('.panel-heading h3')['data-word-id']
  find("button[data-word-id='#{correct_word_id}']").click
end

When(/^I choose incorrect answer$/) do
  correct_word_id = find('.panel-heading h3')['data-word-id']
  all('button[data-word-id]').reject do |e|
    e['data-word-id'] == correct_word_id
  end.sample.click
end

Then(/^I should see correct answer$/) do
  assert_selector("button.card[class*='btn-success']")
end

Then(/^I should see incorrect answer$/) do
  assert_selector("button.card[class*='btn-danger']")
end

Then(/^I should see "([^"]*)" in search field$/) do |value|
  expect(find('#q')['value']).to eq(value)
end

def create_guest
  User.where(email: 'guest@localhost').first || FactoryGirl.create(:user)
end
