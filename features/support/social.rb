def login_with(provider, username, password)
  method = "login_#{provider}"
  if self.class.private_method_defined?(method)
    send(method, username, password)
  else
    raise "Unsupported provider #{provider}"
  end
end

def login_vkontakte(username, password)
  wait_for_visible(:fillable_field, 'email')
  wait_for_visible(:fillable_field, 'pass')
  fill_in('email', with: username)
  fill_in('pass', with: password)
  click_link_or_button('Log in')
  click_link_or_button('Allow') if first(:link_or_button, 'Allow')
end

def login_google(username, password)
  fill_in('email', with: username)
  click_link_or_button('Next')
  fill_in('Password', with: password)
  click_link_or_button('Sign in')
  click_link_or_button('Allow')
end

def login_facebook(username, password)
  within('#loginform') do
    fill_in('email', with: username)
    fill_in('pass', with: password)
    click_link_or_button('Log In')
  end
  click_link_or_button('Continue as') if current_url.include?('facebook.com')
end
