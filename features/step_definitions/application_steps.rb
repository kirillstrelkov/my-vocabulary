Given(/^I am on main page$/) do
  visit('/')
end

Given(/^I am logged in as "([^"]*)"$/) do |username|
  create_guest if username.downcase == 'guest'
  visit('/users/sign_in')
  click_button('Try it')
  assert_text('Logout')
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

When(/^I choose first translation$/) do
  first(:css, '.translation').click
end

When(/^I select "([^"]*)" test file$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I login with "([^"]*)" account$/) do |provider|
  provider.downcase!
  click_link_or_button("Sign in with #{provider.capitalize}")
  if redirected?
    case provider
    when 'facebook'
      puts 'facebook'
    when 'google'
      puts 'google'
    when 'vkontakte'
      fill_in('email', with: ENV['VKONTAKTE_TEST_USERNAME'])
      fill_in('pass', with: ENV['VKONTAKTE_TEST_PASSWORD'])
      click_link_or_button('Log in')
      click_link_or_button('Allow') if first(:link_or_button, 'Allow')
    else
      raise "Unsupported account: #{provider}"
    end
  end
end

When(/^I choose correct answer$/) do
  correct_word_id = find('.panel-heading h3')['data-word-id']
  find("button[data-word-id='#{correct_word_id}']").click
end

When(/^I choose incorrect answer$/) do
  correct_word_id = find('.panel-heading h3')['data-word-id']
  all("button[data-word-id]").select do |e|
    e['data-word-id'] != correct_word_id
  end.sample.click
end

Then(/^I should see correct answer$/) do
  assert_selector("button.card[class*='btn-success']")
end

Then(/^I should see incorrect answer$/) do
  assert_selector("button.card[class*='btn-danger']")
end

def create_guest
  User.where(email: 'guest@localhost').first || FactoryGirl.create(:user)
end
