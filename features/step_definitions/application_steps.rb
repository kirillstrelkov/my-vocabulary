Given(/^I am on main page$/) do
  visit('/')
end

Given(/^the following words exist:$/) do |table|
  data = table.raw
  header = data.first
  Word.destroy_all
  data[1..-1].each do |row|
    FactoryGirl.create(:word, Hash[header.zip(row)])
  end
end

When(/^I select "([^"]*)" test file$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I login with "([^"]*)" account$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
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
