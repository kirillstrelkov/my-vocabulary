Given(/^I am on "([^"]*)"$/) do |url|
  visit(url)
end

When(/^I click "([^"]*)"$/) do |locator|
  click_link_or_button(locator)
end

Then(/^I should be on "([^"]*)"$/) do |url|
  expect(current_url).to eq(url)
end

Then(/^I should see "([^"]*)" within (\d+) seconds$/) do |text, timeout|
  assert_text(text, wait: timeout.to_f)
end

Then(/^I should see "([^"]*)" on page$/) do |text|
  assert_text(text)
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |locator, text|
  fill_in(locator, with: text)
end

When(/^I fill in css element "([^"]*)" with "([^"]*)"$/) do |locator, text|
  find(:css, locator).set(text)
end

When(/^I click css element "([^"]*)"$/) do |locator|
  find(:css, locator).click
end

And(/^I select "([^"]*)" from "([^"]*)"$/) do |text, locator|
  select(text, from: locator)
end