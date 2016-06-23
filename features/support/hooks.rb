After do |scenario|
  if scenario.failed?
    timestamp = Time.now.strftime('%Y%m%d%T')
    puts("Saving screenshots/#{timestamp}.png to screenshots folder!")
    save_screenshot("screenshots/#{timestamp}.png")
  end
end

Before do |scenario|
  if scenario.source_tag_names.include?('@mobile') && !$mobile_drivers.include?($driver)
    skip_this_scenario("Mobile scenario cannot be used with #{$driver} driver")
  end
  $exec_once = $exec_once || false
  current_window.maximize if !$exec_once && Capybara.default_driver == :selenium
end
